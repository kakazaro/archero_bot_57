from PyQt5 import QtWidgets, QtGui
from PyQt5.QtWidgets import QHBoxLayout, QBoxLayout, QVBoxLayout, QPushButton, QWidget, QScrollArea, QLabel, \
    QFormLayout, QGridLayout
from PyQt5 import QtCore
from PyQt5.QtCore import Qt, QSize, pyqtSignal
from PyQt5 import QtWidgets, uic
from QMyWidgets.QLevelState import QLevelState, PlayState
from GameController.GameControllerController import GameControllerController
from GameController.GameControllerModel import GameControllerModel
from QMyWidgets.QDarkButton import QDarkButton


class QDungeonController(QWidget):

    def __init__(self, parent: QWidget, controller: GameControllerController, model: GameControllerModel):
        super(QWidget, self).__init__()
        self.model = model
        self.controller = controller
        self.btn_play = QDarkButton()
        self.btn_stop = QDarkButton()
        self.setAttribute(QtCore.Qt.WA_StyledBackground, True)
        self.setStyleSheet("background-color: rgb(43, 43, 43)")
        self.buttonsSize = 50
        self.initUI()
        self.initSignals()

    def initButton(self, button, icon_name):
        button.setIconPath(self.model.getIconPath(icon_name))
        button.changeSize(self.buttonsSize)
        for k, state_btn in self.controller.controllerStates.items():
            if k == icon_name:
                button.changeEnableState(state_btn)
                break

    def initUI(self):
        lay = QHBoxLayout()
        lay.setAlignment(Qt.AlignCenter)
        self.initButton(self.btn_play, icon_name='play')
        self.initButton(self.btn_stop, icon_name='stop')
        lay.addWidget(self.btn_play)
        lay.addWidget(self.btn_stop)
        self.setLayout(lay)

    def initSignals(self):
        self.btn_play.buttonClicked.connect(self.controller.playRequested)
        self.btn_stop.buttonClicked.connect(self.controller.stopRequested)
        self.controller.onChangeEnableStatesButtons.connect(self.changeButtonsState)

    def changeButtonsState(self, buttons: dict):
        for name, enabled in buttons.items():
            if name == 'play':
                self.btn_play.changeEnableState(enabled)
            elif name == 'stop':
                self.btn_stop.changeEnableState(enabled)
            else:
                print("No button called %s exists in QDungeonController" % name)
