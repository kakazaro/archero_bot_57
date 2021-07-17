#!/usr/bin/env lua
-- MIT License

-- Copyright (c) 2020 Arzaroth

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

menuVisible = 0
configFile = gg.getFile() .. '.cfg'
resourcesSpec = {
    {id=30101, name="Weapon Scroll"},
    {id=30102, name="Armor Scroll"},
    {id=30103, name="Ring Scroll"},
    {id=30104, name="Spirit Scroll"},
    {id=30105, name="Locket Scroll"},
    {id=30106, name="Bracelet Scroll"},
    {id=30107, name="Magic Scroll"},
    {id=31001, name="Sapphire"},
}
itemsSpec = {
    {
        {id=1010101, name="Brave Bow"},
        {id=1010201, name="Death Scythe"},
        {id=1010301, name="Saw Blade"},
        {id=1010401, name="Tornado"},
        {id=1010501, name="Stalker Staff"},
        {id=1010601, name="Brightspear"},
    },
    {
        {id=1020101, name="Golden Chestplate"},
        {id=1020201, name="Vest of Dexterity"},
        {id=1020301, name="Phantom Cloak"},
        {id=1020401, name="Void Robe"},
    },
    {
        {id=1030101, name="Bear Ring"},
        {id=1030201, name="Wolf Ring"},
        {id=1030301, name="Falcon Ring"},
        {id=1030401, name="Serpent Ring"},
        {id=1030501, name="Bull Ring"},
        {id=1030601, name="Lion Ring"},
    },
    {
        {id=1040101, name="Elf"},
        {id=1040201, name="Scythe Mage"},
        {id=1040301, name="Living Bomb"},
        {id=1040401, name="Laser Bat"},
    },
    {
        {id=1050101, name="Agile Locket"},
        {id=1050201, name="Iron Locket"},
        {id=1050301, name="Angel Locket"},
        {id=1050401, name="Bulletproof Locket"},
    },
    {
        {id=1060101, name="Thunder Bracelet"},
        {id=1060201, name="Frozen Bracelet"},
        {id=1060301, name="Blazing Bracelet"},
        {id=1060401, name="Split Bracelet"},
    },
    {
        {id=1070101, name="Arcane Archer"},
        {id=1070201, name="Ice Realm"},
        {id=1070301, name="Enlightenment"},
        {id=1070401, name="Art of Combat"},
    },
}
heroSpecs = {
    {id=10000, name="Atreus", attack=150, hp=600, purchasable=false},
    {id=10001, name="Urasil", attack=120, hp=550, purchasable=false},
    {id=10002, name="Phoren", attack=130, hp=500, purchasable=false},
    {id=10003, name="Taranis", attack=130, hp=550, purchasable=false},
    {id=10004, name="Helix", attack=125, hp=620, purchasable=false},
    {id=10005, name="Meowgik", attack=135, hp=550, purchasable=false},
    {id=10006, name="Shari", attack=135, hp=550, purchasable=false},
    {id=20001, name="Onir", attack=140, hp=650, purchasable=true},
    {id=20002, name="Rolla", attack=170, hp=500, purchasable=true},
    {id=20003, name="Bonnie", attack=150, hp=600, purchasable=true},
    {id=20004, name="Sylvan", attack=160, hp=600, purchasable=true},
    {id=20005, name="Shade", attack=170, hp=550, purchasable=true},
}

function map(tbl, f)
    local t = {}
    for key, value in pairs(tbl) do
        t[key] = f(value)
    end

    return t
end

function filter(tbl, f)
    local t = {}
    for key, value in pairs(tbl) do
        if f(value, key) then
            t[key] = value
        end
    end

    return t
end

function loadConfig()
    local config = loadfile(configFile)
    if config ~= nil then
        config = config()
    end
    if config == nil then
        config = {}
    end
    local package = gg.getTargetPackage()
    if package == nil then
        package = 'none'
    end

    return config[package] or {}
end

function saveConfig(config)
    local package = gg.getTargetPackage()
    if package == nil then
        package = 'none'
    end
	gg.saveVariable({[package]=config}, configFile)
end

function energyHack()
    local config = loadConfig()
    local values = gg.prompt(
        {'☁ Your Current Level', '⚡ Your Current Energy', '💰 Your Current Gold', '💎 Your Current Gems', '👼 Infinite revives'},
        config.energy or {},
        {'number', 'number', 'number', 'number', 'checkbox'}
    )
    if values == nil then
        return
    end
    config.energy = values
    saveConfig(config)
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(
        values[3] .. ';' .. values[4] .. ';0~~0;0~~0;0~~0;' .. values[2] .. ';0~~0;0~~0;' .. values[1] .. '::37',
        gg.TYPE_DWORD, false, gg.SIGN_EQUAL
    )
    local results = gg.getResults(100)
    local newValues = {}
    for index, value in ipairs(results) do
        if index == 6 or (values[5] and index == 7) then
            table.insert(newValues, {
                address=value.address,
                flags=gg.TYPE_DWORD,
                value='500',
                freeze=true,
            })
        end
    end
    gg.addListItems(newValues)
    gg.toast('Energy hack done', true)
    gg.clearResults()
end

function wheelHack()
    local config = loadConfig()
    local values = gg.prompt(
        {'Gold1', 'Gold2', 'Gold3', 'Gold you want'},
        config.wheel or {},
        {'number', 'number', 'number', 'number'}
    )
    if values == nil then
        return
    end
    config.wheel = values
    saveConfig(config)
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(
        values[1] .. ';' .. values[2] .. ';' .. values[3],
        gg.TYPE_DWORD, false, gg.SIGN_EQUAL
    )
    local results = gg.getResults(1000)
    local newValues = {}
    for index, value in ipairs(results) do
        table.insert(newValues, {
            address=value.address,
            flags=gg.TYPE_DWORD,
            value=values[4],
        })
    end
    gg.setValues(newValues)
    gg.toast('Gold hack done, click the GG icon once you\'ve collected gold from the wheel', false)
    local block = true
    while (block) do
        if gg.isVisible(true) then
            block = false
            gg.setVisible(false)
        end
        gg.sleep(100)
    end
    gg.setValues(results)
    gg.clearResults()
    gg.toast('Cleaning up done', true)
end

function oneHitKillHack()
    local config = loadConfig()
    local values = gg.prompt(
        {'🏹 Attack', '❤ Health'},
        config.onehitkill or {},
        {'number', 'number'}
    )
    if values == nil then
        return
    end
    config.onehitkill = values
    saveConfig(config)
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(
        values[1] .. ';' .. values[1] .. ';' .. values[2] .. '::',
        gg.TYPE_DWORD, false, gg.SIGN_EQUAL
    )
    gg.searchNumber(values[1], gg.TYPE_DWORD, false, gg.SIGN_EQUAL)
    gg.getResults(150)
    gg.editAll('500000', gg.TYPE_DWORD)
    gg.toast('One hit kill hack done', true)
    gg.clearResults()
end

function oneHitKillDuoHack()
    local hero = gg.choice(
        map(heroSpecs, function(hero) return hero.name end),
        nil,
        'Select your current hero'
    )
    if hero == nil then
        return
    end
    hero = heroSpecs[hero]
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(
        hero.attack .. ';' .. hero.attack .. ';' .. hero.hp .. '::',
        gg.TYPE_DWORD, false, gg.SIGN_EQUAL
    )
    gg.searchNumber(hero.attack, gg.TYPE_DWORD, false, gg.SIGN_EQUAL)
    gg.getResults(150)
    gg.editAll('500000', gg.TYPE_DWORD)
    gg.toast('One hit kill duo hack done', true)
    gg.clearResults()
end

function godModeHack()
    local config = loadConfig()
    local values = gg.prompt(
        {'❤ Current health', '❤ Maximum health', 'Reverse effect (die in one hit)'},
        config.godmode or {},
        {'number', 'number', 'checkbox'}
    )
    if values == nil then
        return
    end
    config.godmode = values
    saveConfig(config)
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(
        values[1] .. ';0;' .. values[2] .. '::9',
        gg.TYPE_DWORD, false, gg.SIGN_EQUAL
    )
    local results = gg.getResults(1)
    for index, value in ipairs(results) do
        if values[3] then
            value.value = 1
            value.freeze = false
        else
            value.value = values[2]
            value.freeze = true
        end
    end
    if values[3] then
        gg.setValues(results)
    else
        gg.addListItems(results)
    end
    gg.toast('God mode hack done', true)
    gg.clearResults()
end

function changeScrollNumber(resource)
    local config = loadConfig()
    local values = gg.prompt(
        {string.format('Current number of %s', resource.name), 'Desired number'},
        config.resourcesEdit or {},
        {'number', 'number'}
    )
    if values == nil then
        return
    end
    config.resourcesEdit = values
    saveConfig(config)
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(
        resource.id .. ';1;' .. values[1] .. '::9',
        gg.TYPE_DWORD, false, gg.SIGN_EQUAL
    )
    local resultNumber = gg.getResultsCount()
    if resultNumber % 3 == 0 then
        local results = gg.getResults(150)
        local newValues = {}
        for index, result in ipairs(results) do
            if index % 3 == 0 then
                result.value = values[2]
                table.insert(newValues, result)
            end
        end
        gg.setValues(newValues)
        gg.toast(string.format('%s number hack done', resource.name), true)
    else
        gg.toast(string.format('No matching values for %s found', resource.name), true)
    end
    gg.clearResults()
end

function resourcesNumberHack()
    local resources = gg.multiChoice(
        map(resourcesSpec, function(item) return item.name end),
        {},
        'Resources to alter'
    )
    if resources == nil then
        return
    end
    for index, checked in pairs(resources) do
        if checked then
            local resource = resourcesSpec[index]
            changeScrollNumber(resource)
        end
    end
end

function transformResourceIntoItem(resource)
    local config = loadConfig()
    local values = gg.prompt(
        {string.format('Current number of %s', resource.name)},
        config.itemResourceEdit or {},
        {'number'}
    )
    if values == nil then
        return
    end
    local itemType = gg.choice(
        {'⚔ Weapon', '🛡 Armor', '💍 Ring', '🦇 Spirit', '📿 Locket', '💫 Bracelet', '📚 Spellbook'},
        nil,
        'Choose an item type'
    )
    if itemType == nil then
        return
    end
    local item = gg.choice(
        map(itemsSpec[itemType], function(item) return item.name end),
        nil,
        'Choose an item'
    )
    if item == nil then
        return
    end
    config.itemResourceEdit = values
    saveConfig(config)
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(
        resource.id .. ';1;' .. values[1] .. '::9',
        gg.TYPE_DWORD, false, gg.SIGN_EQUAL
    )
    local resultNumber = gg.getResultsCount()
    if resultNumber % 3 == 0 then
        local results = gg.getResults(150)
        local newValues = {}
        for index, result in ipairs(results) do
            if index % 3 == 1 then
                result.value = itemsSpec[itemType][item].id
                table.insert(newValues, result)
            end
            if index % 3 == 0 then
                result.value = 1
                table.insert(newValues, result)
            end
        end
        gg.setValues(newValues)
        gg.toast(string.format('%s transformation hack done', resource.name), true)
    else
        gg.toast(string.format('No matching values for %s found', resource.name), true)
    end
    gg.clearResults()
end

function itemHack()
    local config = loadConfig()
    local resource = gg.choice(
        map(resourcesSpec, function(item) return item.name end),
        nil,
        'Resource to transform into an item'
    )
    if resource == nil then
        return
    end
    gg.setRanges(gg.REGION_ANONYMOUS)
    resource = resourcesSpec[resource]
    transformResourceIntoItem(resource)
end

function heroHack()
    local purchasableHeros = filter(heroSpecs, function(hero) return hero.purchasable end)
    local hero = gg.choice(
        map(purchasableHeros, function(hero) return hero.name end),
        nil,
        'Select the hero you want to unlock'
    )
    if hero == nil then
        return
    end
    hero = purchasableHeros[hero]
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(
        '4;0;10001::9',
        gg.TYPE_DWORD, false, gg.SIGN_EQUAL
    )
    gg.searchNumber(10001, gg.TYPE_DWORD, false, gg.SIGN_EQUAL)
    local results = gg.getResults(1000)
    local newValues = {}
    for index, value in ipairs(results) do
        table.insert(newValues, {
            address=value.address,
            flags=gg.TYPE_DWORD,
            value=hero.id,
        })
    end
    gg.setValues(newValues)
    gg.toast('Hero hack done, click the GG icon once you\'ve claimed to hero', false)
    local block = true
    while (block) do
        if gg.isVisible(true) then
            block = false
            gg.setVisible(false)
        end
        gg.sleep(100)
    end
    gg.setValues(results)
    gg.clearResults()
    gg.toast('Cleaning up done', true)
end

function energyHowTo()
    gg.alert(table.concat(
        {
            "Energy hack",
            "0. In lobby",
            "1. Enter your player level",
            "2. Enter your current energy amount",
            "3. Enter your current gold amount",
            "4. Enter your current gem amount",
        }, "\n"
    ))
end

function wheelHowTo()
    gg.alert(table.concat(
        {
            "Lucky wheel hack",
            "0. In game, before rolling the lucky wheel",
            "1. Enter the 3 different gold values in the lucky wheel",
            "2. Enter the desired gold amount",
            "3. After rolling, click the GG icon to cleanup values",
            "Be careful to not set the desired value too high, you may trigger the anti-cheat",
        }, "\n"
    ))
end

function oneHitKillHowTo()
    gg.alert(table.concat(
        {
            "One hit kill hack",
            "0. In game",
            "1. Enter your ATK value in your character sheet",
            "2. Enter your HP value in your character sheet",
        }, "\n"
    ))
end

function oneHitKillDuoHowTo()
    gg.alert(table.concat(
        {
            "One hit kill duo mode hack",
            "0. In game, duo mode",
            "1. Select your current hero",
        }, "\n"
    ))
end

function godModeHowTo()
    gg.alert(table.concat(
        {
            "God mode hack",
            "0. In game",
            "1. Enter your current HP in-game value",
            "2. Enter your maximum HP in-game value",
            "3. Enable the option if you wish to die in one hit instead",
            "Note that you can still die if you take more damage than your maximum health",
        }, "\n"
    ))
end

function resourcesNumberHowTo()
    gg.alert(table.concat(
        {
            "Resources hack",
            "0. In game, after looting a resource, before leaving the room",
            "1. Choose a resource you've collected",
            "2. Enter the total number you've collected",
            "3. Choose the desired number",
            "Be careful to not set the desired value too high, you may trigger the anti-cheat",
        }, "\n"
    ))
end

function itemHowTo()
    gg.alert(table.concat(
        {
            "Item hack",
            "0. In game, after looting a resource, before leaving the room",
            "1. Choose a resource you've collected",
            "2. Enter the total number you've collected",
            "3. Choose the desired item",
            "Note that you cannot loot more than 3 items per game (5 in flying bullets)",
            "Be careful when hacking for spellbooks, the anti-cheat is aggressive",
        }, "\n"
    ))
end

function heroHowTo()
    gg.alert(table.concat(
        {
            "Hero hack",
            "0. In lobby, on hero selection screen",
            "1. Select any hero other than Urasil",
            "2. Choose the derised hero you want to unlock",
            "3. Go to Urasil and claim him",
            "4. Click the GG icon to cleanup values",
        }, "\n"
    ))
end

function howToHack()
    local choice = gg.choice(
        {
            '⚡ Energy in lobby',
            '🎡 Gold in lucky wheel',
            '💀 One hit kill in game',
            '💀 One hit kill in duo mode',
            '❤️ God mode',
            '📜 Number of resources in game (scrolls, sapphire)',
            '🔃 Transform a resource into an item in game',
            '🧝‍♂️ Unlock heroes',
        },
        nil,
        'How to use hacks'
    )
    if choice ~= nil then
        local methods = {
            energyHowTo,
            wheelHowTo,
            oneHitKillHowTo,
            oneHitKillDuoHowTo,
            godModeHowTo,
            resourcesNumberHowTo,
            itemHowTo,
            heroHowTo,
        }
        methods[choice]()
    end
end

function exitHack()
    os.exit()
end

function showMenu()
    local choice = gg.choice(
        {
            '⚡ Energy in lobby',
            '🎡 Gold in lucky wheel',
            '💀 One hit kill in game',
            '💀 One hit kill in duo mode',
            '❤️ God mode',
            '📜 Number of resources in game (scrolls, sapphire)',
            '🔃 Transform a resource into an item in game',
            '🧝‍♂️ Unlock heroes',
            '🆘 How to',
            '❌ Exit',
        },
        nil,
        '~~ Archero hack menu ~~ by Arzaroth ~~'
    )
    if choice ~= nil then
        local methods = {
            energyHack,
            wheelHack,
            oneHitKillHack,
            oneHitKillDuoHack,
            godModeHack,
            resourcesNumberHack,
            itemHack,
            heroHack,
            howToHack,
            exitHack,
        }
        methods[choice]()
    end
    menuVisible = 0
end

while (true) do
    if gg.isVisible(true) then
        menuVisible = 1
        gg.setVisible(false)
    end
    if menuVisible == 1 then
        showMenu()
    end
    gg.sleep(100)
end
