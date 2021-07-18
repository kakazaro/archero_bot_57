import time
from datetime import datetime
from PyQt5.QtCore import QObject, pyqtSignal
from UsbConnector import UsbConnector
from GameScreenConnector import GameScreenConnector
from StatisticsManager import StatisticsManager
from Utils import loadJsonData, saveJsonData_oneIndent, saveJsonData_twoIndent, readAllSizesFolders, buildDataFolder, \
    getCoordFilePath
import enum
from random import seed
from random import random

# seed random number generator
seed(1)


class HealingStrategy(enum.Enum):
    AlwaysHeal = 0
    AlwaysPowerUp = 1


class CaveEngine(QObject):
    levelChanged = pyqtSignal(int)
    addLog = pyqtSignal(str)
    resolutionChanged = pyqtSignal(int, int)
    dataFolderChanged = pyqtSignal(str)
    noEnergyLeft = pyqtSignal()
    gameWon = pyqtSignal()
    healingStrategyChanged = pyqtSignal(bool)

    # onDictionaryTapsChanged = pyqtSignal(dict)
    # onButtonLocationChanged = pyqtSignal(str)
    # onImageSelected = pyqtSignal()
    MAX_LEVEL = 1

    # Set this to true if you want to use generated data with TouchManager. Uses below coordinates path
    UseGeneratedData = False
    # Set this to true if keep receiving "No energy, wqiting for one minute"
    UseManualStart = False
    # Set this to true if want to automatically check for energy
    SkipEnergyCheck = False
    data_pack = 'datas'
    coords_path = 'coords'
    buttons_filename = "buttons.json"
    movements_filename = "movements.json"
    print_names_movements = {
        "n": "up",
        "s": "down",
        "e": "right",
        "w": "left",
        "ne": "up-right",
        "nw": "up-left",
        "se": "down-right",
        "sw": "down-left",
    }

    t_intro = 'intro'
    t_normal = 'normal'

    all_levels_type = {
        0: t_intro,
        1: t_normal,
    }

    max_loops_game = 1000

    def __init__(self, connectImmediately: bool = False):
        super(QObject, self).__init__()
        self.currentLevel = 0
        self.currentDungeon = 1
        self.statisctics_manager = StatisticsManager()
        self.start_date = datetime.now()
        self.stat_lvl_start = 0
        self.screen_connector = GameScreenConnector()
        self.screen_connector.debug = False
        self.width, self.heigth = 1080, 2220
        self.device_connector = UsbConnector()
        self.device_connector.setFunctionToCallOnConnectionStateChanged(self.onConnectionStateChanged)
        self.buttons = {}
        self.movements = {}
        self.disableLogs = False
        self.stopRequested = False
        self.currentDataFolder = ''
        self.dataFolders = {}
        self.healingStrategy = HealingStrategy.AlwaysPowerUp
        self.centerAfterCrossingDungeon = False
        if connectImmediately:
            self.initDeviceConnector()
        self.check_seconds = 4

    def getLevelsType(self):
        return self.all_levels_type

    def initDataFolders(self):
        self.dataFolders = readAllSizesFolders()
        deviceFolder = buildDataFolder(self.width, self.heigth)
        first_folder = list(self.dataFolders.keys())[0]
        if deviceFolder not in self.dataFolders:
            print("Error: not having %s coordinates. Trying with %s" % (deviceFolder, first_folder))
            deviceFolder = first_folder
        self.changeCurrentDataFolder(deviceFolder)

    def initdeviceconnector(self):
        self.device_connector.connect()

    def changeHealStrategy(self, always_heal: bool):
        self.healingStrategy = HealingStrategy.AlwaysHeal if always_heal else HealingStrategy.AlwaysPowerUp
        self.healingStrategyChanged.emit(always_heal)

    def changeChapter(self, new_chapter):
        self.currentDungeon = new_chapter

    def onConnectionStateChanged(self, connected):
        if connected:
            self.initDataFolders()
            self.screen_connector.changeDeviceConnector(self.device_connector)
            self.updateScreenSizeByPhone()

    def updateScreenSizeByPhone(self):
        if self.device_connector is not None:
            w, h = self.device_connector.adb_get_size()
            self.changeScreenSize(w, h)
            self.screen_connector.changeScreenSize(w, h)
        else:
            print("Device connector is none. initialize it before calling this method!")

    def changeCurrentDataFolder(self, new_folder):
        self.currentDataFolder = new_folder
        self.loadCoords()
        self.dataFolderChanged.emit(new_folder)

    def loadCoords(self):
        self.buttons = loadJsonData(getCoordFilePath(self.buttons_filename, sizePath=self.currentDataFolder))
        self.movements = loadJsonData(getCoordFilePath(self.movements_filename, sizePath=self.currentDataFolder))

    def setStopRequested(self):
        self.stopRequested = True
        self.screen_connector.stopRequested = True
        self.statisctics_manager.saveOneGame(self.start_date, self.stat_lvl_start, self.currentLevel)

    def changeScreenSize(self, w, h):
        self.width, self.heigth = w, h
        print("New resolution set: %dx%d" % (self.width, self.heigth))
        self.changeCurrentDataFolder("%dx%d" % (self.width, self.heigth))
        self.resolutionChanged.emit(w, h)

    def __unused__initConnection(self):
        device = self.device_connector._get_device_id()
        if device is None:
            print("Error: no device discovered. Start adb server before executing this.")
            exit(1)
        print("Usb debugging device: %s" % device)

    def log(self, log: str):
        """
        Logs an important move in the bot game
        """
        if not self.disableLogs:
            self.addLog.emit(log)

    def swipe_points(self, start, stop, s):
        start = self.buttons[start]
        stop = self.buttons[stop]
        print("Swiping between %s and %s in %f" % (start, stop, s))
        self.device_connector.adb_swipe(
            [start[0] * self.width, start[1] * self.heigth, stop[2] * self.width, stop[3] * self.heigth], s)

    def swipe(self, name, s):
        if self.stopRequested:
            exit()
        coord = self.movements[name]
        print("Swiping %s in %f" % (self.print_names_movements[name], s))
        self.log("Swipe %s in %.2f" % (self.print_names_movements[name], s))
        # convert back from normalized values
        self.device_connector.adb_swipe(
            [coord[0][0] * self.width, coord[0][1] * self.heigth, coord[1][0] * self.width, coord[1][1] * self.heigth],
            s)

    def tap(self, name):
        if self.stopRequested:
            exit()
        self.log("Tap %s" % name)
        # convert back from normalized values
        x, y = int(self.buttons[name][0] * self.width), int(self.buttons[name][1] * self.heigth)
        print("Tapping on %s at [%d, %d]" % (name, x, y))
        self.device_connector.adb_tap((x, y))

    def wait(self, s):
        decimal = s
        if int(s) > 0:
            decimal = s - int(s)
            for _ in range(int(s)):
                if self.stopRequested:
                    exit()
                time.sleep(1)
        if self.stopRequested:
            exit()
        time.sleep(decimal)

    def centerPlayer(self):
        px, dir = self.screen_connector.getPlayerDecentering()
        # Move in oppositye direction. Speed is made by y = mx + q
        duration = 0.019 * abs(px) - 4.8
        if px < self.screen_connector.door_width / 2.0:
            pass
        if dir == 'left':
            self.log("Centering player <--")
            self.swipe('e', duration)
        elif dir == 'right':
            self.log("Centering player -->")
            self.swipe('w', duration)
        elif dir == "center":
            pass

    def _exitEngine(self):
        self.statisctics_manager.saveOneGame(self.start_date, self.stat_lvl_start, self.currentLevel)
        exit(1)

    def reactGamePopups(self, frame=None) -> int:
        last_state = frame
        state = ""
        i = 0
        reacted = False
        while state != "in_game":
            if self.stopRequested:
                exit()
            if i > self.max_loops_game:
                print("Max loops reached")
                self.log("Max loops reached")
                self._exitEngine()
            self.log("screen check")
            state = self.screen_connector.getFrameState(last_state)
            last_state = None
            print("state: %s" % state)
            if state == "select_ability":
                self.tap('ability_left')
                self.tap('ability_right')
                self.wait(1.5)
            elif state == "fortune_wheel":
                self.tap('lucky_wheel_start')
                self.wait(7)
            elif state == "repeat_endgame_question":
                self.tap('spin_wheel_back')
                self.wait(1.5)
            elif state == "devil_question":
                self.tap('ability_daemon_reject')
                self.wait(1.5)
            elif state == "ad_ask":
                self.tap('spin_wheel_back')
                self.wait(1.5)
            elif state == "mistery_vendor":
                self.tap('spin_wheel_back')
                self.wait(1.5)
            elif state == "special_gift_respin":
                self.tap('spin_wheel_back')
                self.wait(1.5)
            elif state == "angel_heal":
                self.tap('heal_right' if self.healingStrategy == HealingStrategy.AlwaysHeal else 'heal_left')
                self.wait(1.5)
            elif state == "on_pause":
                self.tap('resume')
                self.wait(1.5)
            elif state == "time_prize":
                print("Collecting time prize and ending game. Unexpected behaviour but managed")
                self.tap("close_time_reward")
                self.wait(3)
                raise Exception('ended')
            elif state == "endgame":
                self.wait(10)
                self.tap('close_end')
                raise Exception('ended')
            i += 1
            if state != "in_game":
                reacted = True
            self.wait(.1)
        return reacted

    def intro_lvl(self):
        self.wait(3)
        self.tap('ability_daemon_reject')
        self.tap('ability_left')
        self.tap('ability_right')
        if self.screen_connector.checkFrame("gg_bottom"):
            print('Hack God Mode')
            self.tap("click_gg_button")
            self.wait(1)
            self.tap("hack_godmode")
            self.wait(5)
        else:
            print('Not found Game Guardian')
        self.swipe('n', 3)
        self.wait(2)
        self.tap('lucky_wheel_start')
        self.wait(5)
        self.swipe('n', 2)

    move_new = {
        'w': ['nw', ['sw', 's']],
        'e': ['ne', ['se', 's']]
    }

    def play_forever(self):
        print('play new game')
        last_position = {'w': None, 'e': None}
        dir_move = 'w'

        while True:
            self.swipe('n', 0.2 + random())
            self.swipe(self.move_new[dir_move][0], 1 + random())

            frame = self.screen_connector.getFrame()
            if self.reactGamePopups(frame):
                last_position = {'w': None, 'e': None}
            else:
                # save player position
                px, dir, corner = self.screen_connector.getPlayerDecentering(frame)
                if last_position[dir_move] is not None:
                    diff = abs(px - last_position[dir_move])
                    print('diff %dpx' % diff)
                    if diff <= 15:
                        back_dir = 'w' if random() > .5 else 'e'
                        if random() > .5:
                            # try back with dir
                            self.swipe('s' + back_dir, (0.5 + random()))
                        else:
                            # try back to south
                            self.swipe('s', (0.5 + random()))

                        self.swipe('n' + back_dir, (1 + random()))
                        px = None

                last_position[dir_move] = px
                dir_move = 'e' if dir_move == 'w' else 'w'

    def play_cave(self):
        self.levelChanged.emit(self.currentLevel)
        while True:
            level = self.getLevelsType()[self.currentLevel]
            print("Level %d: %s" % (self.currentLevel, str(level)))
            if level == self.t_intro:
                self.intro_lvl()
            elif level == self.t_normal:
                self.play_forever()
                break
            self.changeCurrentLevel(self.currentLevel + 1)
        self.wait(2)
        if self.screen_connector.checkFrame('endgame'):
            self.tap('close_end')
            self.gameWon.emit()
            print('You won!!!')

    def changeCurrentLevel(self, new_lvl):
        self.currentLevel = new_lvl
        self.levelChanged.emit(self.currentLevel)

    def chooseCave(self):
        print("Main menu")
        self.tap('start')
        self.wait(3)
        if self.screen_connector.checkFrame("btn_home_raid"):
            print("Ignore Raid")
            self.tap('start_ignore_raid')
            self.wait(3)

    def start_play(self):
        while True:
            self.start_one_game()
            self.currentLevel = 0
            if self.currentDungeon != 1:
                break
            print('Remake incoming......')

    def press_close_end_if_ended_frame(self):
        if self.screen_connector.checkFrame('endgame'):
            self.tap('close_end')

    def start_one_game(self):
        self.start_date = datetime.now()
        self.stat_lvl_start = self.currentLevel
        self.stopRequested = False
        self.screen_connector.stopRequested = False
        self.log("New game started")
        print("New game. Starting from level %d" % self.currentLevel)
        self.wait(4)
        if self.screen_connector.checkFrame("time_prize"):
            print("ignore time prize")
            self.tap("close_time_reward")
            self.wait(3)
        if self.currentLevel == 0:
            if self.UseManualStart:
                a = input("Press enter to start a game (your energy bar must be at least 5)")
            else:
                while (not self.SkipEnergyCheck) and not self.screen_connector.checkFrame("least_5_energy"):
                    print("No energy, waiting for one minute")
                    self.noEnergyLeft.emit()
                    self.wait(60)
            self.chooseCave()
        try:
            self.play_cave()
        except Exception as exc:
            self.press_close_end_if_ended_frame()
            if exc.args[0] == 'ended':
                print("Game ended. Farmed a little bit...")
            elif exc.args[0] == 'unable_exit_dungeon':
                print("Unable to exit a room in a dungeon. Waiting instead of causing troubles")
                self._exitEngine()
            elif exc.args[0] == "unknown_screen_state":
                print("Unknows screen state. Exiting instead of doing trouble")
                self._exitEngine()
            else:
                print("Got an unknown exception: %s" % exc)
                self._exitEngine()
        print('end of play')
        self.press_close_end_if_ended_frame()
        self.statisctics_manager.saveOneGame(self.start_date, self.stat_lvl_start, self.currentLevel)
