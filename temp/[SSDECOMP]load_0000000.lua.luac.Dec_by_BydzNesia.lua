function GG()
  A = gg.choice({
    "1️⃣ Hack energy",
    "2️⃣ Hack gold",
    "3️⃣ Hack one hit",
    "4️⃣ +max items",
    "5️⃣ +30 kinds of different paper ",
    "6️⃣ Cheat Open Box",
    "❎Exit❎"
  }, nil, "Menu hack archero Anti Band")
  if A == nil then
  else
    if A == 1 then
      ga()
    end
    if A == 2 then
      gb()
    end
    if A == 3 then
      gc()
    end
    if A == 4 then
      gd()
    end
    if A == 5 then
      ge()
    end
    if A == 6 then
      gf()
    end
    if A == 7 then
      gh()
    end
  end
  AC = -1
end
function ga()
  B = gg.multiChoice({
    "1️⃣ Hack energy TYPE 1",
    "2️⃣ Hack energy TYPE 2\nNOTE: Only use if TYPE 1 not work",
    "Back"
  })
  if B == nil then
  else
    if B[1] then
      gg.clearResults()
      function getRanges()
        local L0_14
        L0_14 = {}
        L0_14[3] = "x86"
        L0_14[40] = "ARM"
        L0_14[62] = "x86-64"
        L0_14[183] = "AArch64"
        for _FORV_7_, _FORV_8_ in ipairs((gg.getRangesList("^/data/*.so*$"))) do
          if _FORV_8_.type:sub(2, 2) == "-" and gg.getValues({
            {
              address = _FORV_8_.start,
              flags = gg.TYPE_DWORD
            },
            {
              address = _FORV_8_.start + 18,
              flags = gg.TYPE_WORD
            }
          })[1].value == 1179403647 and L0_14[gg.getValues({
            {
              address = _FORV_8_.start,
              flags = gg.TYPE_DWORD
            },
            {
              address = _FORV_8_.start + 18,
              flags = gg.TYPE_WORD
            }
          })[2].value] == nil then
          end
          if _FORV_8_.type:sub(2, 2) == "w" then
            _FORV_8_.arch = "unknown"
            table.insert({}, _FORV_8_)
          end
        end
        return {}
      end
      function out()
        if gg.getTargetInfo().packageName ~= _UPVALUE2_.packageName or gg.getTargetInfo().versionCode ~= _UPVALUE2_.versionCode or gg.getTargetInfo().versionName ~= _UPVALUE2_.versionName or gg.getTargetInfo().x64 ~= _UPVALUE2_.x64 then
        end
        for _FORV_9_, _FORV_10_ in ipairs(_UPVALUE2_) do
          if _FORV_10_.map.new == nil then
            for _FORV_15_, _FORV_16_ in ipairs((getRanges())) do
              if _FORV_10_.map.internalName:gsub("^.*/", "") == _FORV_16_.internalName:gsub("^.*/", "") and _FORV_10_.map.state == _FORV_16_.state then
                if ({
                  [_FORV_10_.map.internalName:gsub("^.*/", "")] = true
                })[_FORV_10_.map.internalName:gsub("^.*/", "")] == nil and _FORV_10_.map.arch ~= _FORV_16_.arch then
                end
                _FORV_10_.map.new = _FORV_16_
                break
              end
            end
          end
          if _FORV_10_.map.new ~= nil then
            for _FORV_14_, _FORV_15_ in ipairs(_FORV_10_) do
              _FORV_15_.address = _FORV_15_.address - _FORV_10_.map.start + _FORV_10_.map.new.start
            end
          end
        end
        while true do
          for _FORV_10_, _FORV_11_ in pairs((gg.getValues({
            [_FORV_15_] = _FORV_15_
          }))) do
            if _FORV_10_.offset == nil then
              table.insert({}, _FORV_11_)
            else
              if not gg.getTargetInfo().x64 then
                _FORV_11_.value = _FORV_11_.value & 4294967295
              end
              for _FORV_15_, _FORV_16_ in pairs(_FORV_10_.offset) do
                _FORV_16_.address = _FORV_11_.value + _FORV_15_
              end
            end
          end
        end
        gg.loadResults({})
      end
      out()
      gg.getResults(100)
      gg.editAll("50", gg.TYPE_DWORD)
      gg.clearResults()
      gg.toast("done", true)
    end
    if B[2] then
      gg.timeJump("3:0:0")
      gg.toast("done")
      gg.clearResults()
    end
    if B[3] then
      return GG()
    end
  end
end
function gb()
  B = gg.multiChoice({
    "1️⃣ Hack Gold TYPE 1",
    "2️⃣ Hack Gold TYPE 2\nNOTE: Only use if TYPE 1 not work",
    "Back"
  })
  if B == nil then
  else
    if B[1] then
      if gg.prompt({
        "Gold you want to cheat: [3000; 20000]"
      }, {9500}, {"number"}) == nil then
        return GG(gg.isVisible(true))
      end
      function getRanges()
        local L0_15
        L0_15 = {}
        L0_15[3] = "x86"
        L0_15[40] = "ARM"
        L0_15[62] = "x86-64"
        L0_15[183] = "AArch64"
        for _FORV_7_, _FORV_8_ in ipairs((gg.getRangesList("^/data/*.so*$"))) do
          if _FORV_8_.type:sub(2, 2) == "-" and gg.getValues({
            {
              address = _FORV_8_.start,
              flags = gg.TYPE_DWORD
            },
            {
              address = _FORV_8_.start + 18,
              flags = gg.TYPE_WORD
            }
          })[1].value == 1179403647 and L0_15[gg.getValues({
            {
              address = _FORV_8_.start,
              flags = gg.TYPE_DWORD
            },
            {
              address = _FORV_8_.start + 18,
              flags = gg.TYPE_WORD
            }
          })[2].value] == nil then
          end
          if _FORV_8_.type:sub(2, 2) == "w" then
            _FORV_8_.arch = "unknown"
            table.insert({}, _FORV_8_)
          end
        end
        return {}
      end
      function out()
        if gg.getTargetInfo().packageName ~= _UPVALUE2_.packageName or gg.getTargetInfo().versionCode ~= _UPVALUE2_.versionCode or gg.getTargetInfo().versionName ~= _UPVALUE2_.versionName or gg.getTargetInfo().x64 ~= _UPVALUE2_.x64 then
        end
        for _FORV_9_, _FORV_10_ in ipairs(_UPVALUE2_) do
          if _FORV_10_.map.new == nil then
            for _FORV_15_, _FORV_16_ in ipairs((getRanges())) do
              if _FORV_10_.map.internalName:gsub("^.*/", "") == _FORV_16_.internalName:gsub("^.*/", "") and _FORV_10_.map.state == _FORV_16_.state then
                if ({
                  [_FORV_10_.map.internalName:gsub("^.*/", "")] = true
                })[_FORV_10_.map.internalName:gsub("^.*/", "")] == nil and _FORV_10_.map.arch ~= _FORV_16_.arch then
                end
                _FORV_10_.map.new = _FORV_16_
                break
              end
            end
          end
          if _FORV_10_.map.new ~= nil then
            for _FORV_14_, _FORV_15_ in ipairs(_FORV_10_) do
              _FORV_15_.address = _FORV_15_.address - _FORV_10_.map.start + _FORV_10_.map.new.start
            end
          end
        end
        while true do
          for _FORV_10_, _FORV_11_ in pairs((gg.getValues({
            [_FORV_15_] = _FORV_15_
          }))) do
            if _FORV_10_.offset == nil then
              table.insert({}, _FORV_11_)
            else
              if not gg.getTargetInfo().x64 then
                _FORV_11_.value = _FORV_11_.value & 4294967295
              end
              for _FORV_15_, _FORV_16_ in pairs(_FORV_10_.offset) do
                _FORV_16_.address = _FORV_11_.value + _FORV_15_
              end
            end
          end
        end
        gg.loadResults({})
      end
      out()
      gg.getResults(100)
      gg.editAll(gg.prompt({
        "Gold you want to cheat: [3000; 20000]"
      }, {9500}, {"number"})[1], gg.TYPE_FLOAT)
      gg.toast("done", true)
      gg.clearResults()
    end
    if B[2] then
      gg.alert("spinning gold spinning wheel before hacking/nQuay bánh xe vàng trước khi hack")
      gg.setRanges(gg.REGION_ANONYMOUS)
      gg.searchNumber(gg.prompt({
        " The gold you just made\n Số vàng bạn vừa quay được",
        "The amount of gold you want\nSố vàng bạn muốn: [3000; 20000]"
      }, {nil, 5000}, {"number", "number"})[1], gg.TYPE_FLOAT)
      gg.getResults(100)
      gg.editAll(gg.prompt({
        " The gold you just made\n Số vàng bạn vừa quay được",
        "The amount of gold you want\nSố vàng bạn muốn: [3000; 20000]"
      }, {nil, 5000}, {"number", "number"})[2], gg.TYPE_DWORD)
    end
    if B[3] then
      GG()
    end
  end
end
function gc()
  if gg.prompt({
    "Attack:",
    "Your health:",
    "Maximum heath:"
  }, {
    nil,
    nil,
    nil
  }, {
    "number",
    "number",
    "number"
  }) == nil then
    return GG(gg.isVisible(true))
  end
  gg.setRanges(gg.REGION_ANONYMOUS)
  gg.searchNumber(gg.prompt({
    "Attack:",
    "Your health:",
    "Maximum heath:"
  }, {
    nil,
    nil,
    nil
  }, {
    "number",
    "number",
    "number"
  })[1] .. ";" .. gg.prompt({
    "Attack:",
    "Your health:",
    "Maximum heath:"
  }, {
    nil,
    nil,
    nil
  }, {
    "number",
    "number",
    "number"
  })[2] .. ";" .. gg.prompt({
    "Attack:",
    "Your health:",
    "Maximum heath:"
  }, {
    nil,
    nil,
    nil
  }, {
    "number",
    "number",
    "number"
  })[3] .. ":" .. 400, gg.TYPE_DWORD, false, gg.SIGN_EQUAL)
  gg.searchNumber(gg.prompt({
    "Attack:",
    "Your health:",
    "Maximum heath:"
  }, {
    nil,
    nil,
    nil
  }, {
    "number",
    "number",
    "number"
  })[1], gg.TYPE_DWORD, false, gg.SIGN_EQUAL)
  gg.getResults(100000)
  gg.editAll("500000", gg.TYPE_DWORD)
  gg.toast("done", true)
  gg.clearResults()
end
function gd()
  gg.clearResults()
  gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_CODE_APP)
  gg.searchNumber("1000000~2000000;2~50;1::10", gg.TYPE_DWORD, false, gg.SIGN_EQUAL)
  gg.refineNumber("1", gg.TYPE_DWORD, false, gg.SIGN_NOT_EQUAL)
  gg.refineNumber("0", gg.TYPE_DWORD, false, gg.SIGN_NOT_EQUAL)
  gg.refineNumber("1000000~2000000", gg.TYPE_DWORD, false, gg.SIGN_NOT_EQUAL)
  gg.getResults(1000)
  gg.editAll(1000, gg.TYPE_DWORD)
  gg.clearList()
  gg.clearResults()
  gg.toast("done", true)
  gg.clearResults()
end
function ge()
  gg.clearResults()
  if gg.prompt({
    "Weapon Paper+30\nGiấy Vũ Khí+30",
    "Armor Paper+30\nGiấy Giáp+30",
    "Ring Paper+30\nGiấy Nhẫn+30",
    "Soul Paper+30\nGiấy Linh hồn+30"
  }, nil, {
    "checkbox",
    "checkbox",
    "checkbox",
    "checkbox"
  }) == nil then
    return GG()
  else
    if gg.prompt({
      "Weapon Paper+30\nGiấy Vũ Khí+30",
      "Armor Paper+30\nGiấy Giáp+30",
      "Ring Paper+30\nGiấy Nhẫn+30",
      "Soul Paper+30\nGiấy Linh hồn+30"
    }, nil, {
      "checkbox",
      "checkbox",
      "checkbox",
      "checkbox"
    })[1] then
      n = 30101
      m = 50
      if gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"}) == nil then
        return ge(gg.isVisible(true))
      end
      gg.setRanges(gg.REGION_ANONYMOUS)
      gg.searchNumber(gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"})[1] .. ";" .. n .. ":" .. m, gg.TYPE_DWORD)
      gg.searchNumber(gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"})[1], gg.TYPE_DWORD)
      gg.getResults(100000)
      gg.editAll(gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"})[2], gg.TYPE_DWORD)
      gg.toast("done", true)
      gg.clearResults()
    end
    if gg.prompt({
      "Weapon Paper+30\nGiấy Vũ Khí+30",
      "Armor Paper+30\nGiấy Giáp+30",
      "Ring Paper+30\nGiấy Nhẫn+30",
      "Soul Paper+30\nGiấy Linh hồn+30"
    }, nil, {
      "checkbox",
      "checkbox",
      "checkbox",
      "checkbox"
    })[2] then
      m = 30102
      h = 50
      if gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"}) == nil then
        return ge(gg.isVisible(true))
      end
      gg.setRanges(gg.REGION_ANONYMOUS)
      gg.searchNumber(gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"})[1] .. ";" .. m .. ":" .. h, gg.TYPE_DWORD)
      gg.searchNumber(gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"})[1], gg.TYPE_DWORD)
      gg.getResults(10)
      gg.editAll(gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"})[2], gg.TYPE_DWORD)
      gg.toast("done", true)
      gg.clearResults()
    end
    if gg.prompt({
      "Weapon Paper+30\nGiấy Vũ Khí+30",
      "Armor Paper+30\nGiấy Giáp+30",
      "Ring Paper+30\nGiấy Nhẫn+30",
      "Soul Paper+30\nGiấy Linh hồn+30"
    }, nil, {
      "checkbox",
      "checkbox",
      "checkbox",
      "checkbox"
    })[3] then
      n = 30103
      m = 50
      if gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"}) == nil then
        return ge(gg.isVisible(true))
      end
      gg.setRanges(gg.REGION_ANONYMOUS)
      gg.searchNumber(gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"})[1] .. ";" .. n .. ":" .. m, gg.TYPE_DWORD)
      gg.searchNumber(gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"})[1], gg.TYPE_DWORD)
      gg.getResults(10)
      gg.editAll(gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"})[2], gg.TYPE_DWORD)
      gg.toast("done", true)
      gg.clearResults()
    end
    if gg.prompt({
      "Weapon Paper+30\nGiấy Vũ Khí+30",
      "Armor Paper+30\nGiấy Giáp+30",
      "Ring Paper+30\nGiấy Nhẫn+30",
      "Soul Paper+30\nGiấy Linh hồn+30"
    }, nil, {
      "checkbox",
      "checkbox",
      "checkbox",
      "checkbox"
    })[4] then
      n = 30104
      m = 50
      if gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"}) == nil then
        return ge(gg.isVisible(true))
      end
      gg.setRanges(gg.REGION_ANONYMOUS)
      gg.searchNumber(gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"})[1] .. ";" .. n .. ":" .. m, gg.TYPE_DWORD)
      gg.searchNumber(gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"})[1], gg.TYPE_DWORD)
      gg.getResults(10)
      gg.editAll(gg.prompt({
        "Number of Rolls received in match: [1; 8]",
        "Number of Rolls you want in match: [9; 35]"
      }, {nil, nil}, {"number", "number"})[2], gg.TYPE_DWORD)
      gg.toast("done", true)
      gg.clearResults()
    end
  end
end
function gf()
  if gg.choice({
    "♠Gold Chess\nRương Vàng♠",
    "♣Purple Chest\nRương tím♣"
  }) == nil then
    GG()
  else
    if gg.choice({
      "♠Gold Chess\nRương Vàng♠",
      "♣Purple Chest\nRương tím♣"
    }) == 1 then
      gg.searchNumber("1010101", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1010102", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1010201", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1010202", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1010301", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1010302", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1010401", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1010402", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1020401", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1020402", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1020301", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1020302", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1020201", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1020202", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1020101", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1020102", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1030101", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.refineNumber("1030102", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.searchNumber("1030301", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1030302", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1030401", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1030402", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1030101", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1030102", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1030201", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1030202", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1030301", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.searchNumber("1020301", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.searchNumber("1020101", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.searchNumber("1040101", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1040102", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1040201", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1040202", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1040301", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1040302", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1040401", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1040402", gg.TYPE_DWORD)
      gg.clearResults()
    end
    if gg.choice({
      "♠Gold Chess\nRương Vàng♠",
      "♣Purple Chest\nRương tím♣"
    }) == 2 then
      gg.searchNumber("1010102~1010103", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1010104", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1010202~1010203", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1010204", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1010302~1010303", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("101030", gg.TYPE_DWORD)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1010304", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1010402~1010403", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1010404", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1020402~1020403", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1020404", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1020302~1020303", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1020304", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1020202~1020303", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.clearResults()
      gg.searchNumber("1020202~1020203", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1020204", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1020102~1020103", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1020104", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1030102~1030103", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1030104", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1030202~1030203", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1030204", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1030302~1030303", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1030304", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1030402~1030403", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1030404", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1040402~1030403", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.searchNumber("1040402~1040403", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1040404", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1040302~1040303", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1040304", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1040402~1040403", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      gg.searchNumber("1040202~1040203", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1040204", gg.TYPE_DWORD)
      gg.clearResults()
      gg.searchNumber("1040102~1040103", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
      revert = gg.getResults(100000, nil, nil, nil, nil, nil, nil, nil, nil)
      gg.editAll("1040104", gg.TYPE_DWORD)
      gg.toast("done")
      gg.clearResults()
    end
  end
end
function gh()
  m = "script by 5G_Controller"
  gg.alert(m, "I known")
  gg.toast(m, true)
  os.exit()
end
while true do
  if gg[(function(A0_16)
    A0_16 = A0_16:gsub(" ", "")
    return (A0_16:gsub("..", function(A0_17)
      return string.char(tonumber(A0_17, 16) - 64)
    end))
  end)("A9 B3 96 A9 B3 A9 A2 AC A5")](true) then
    AC = 1
    gg[(function(A0_18)
      A0_18 = A0_18:gsub(" ", "")
      return (A0_18:gsub("..", function(A0_19)
        return string.char(tonumber(A0_19, 16) - 64)
      end))
    end)("B3 A5 B4 96 A9 B3 A9 A2 AC A5")](false)
  end
  if AC == 1 then
    GG()
  end
end


--We are the tender love in the world.

--By Only SSTool
