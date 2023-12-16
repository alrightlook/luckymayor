local StartPanel = require('Presentation.StartPanel')
local LogicMain = require('logic.main')

GameObject = CS.UnityEngine.GameObject
print("Lua Engine Loaded!")
ResMgr = CS.ResourceManager.ResourceMgr.Inst

UIRoot = CS.UnityEngine.GameObject.Find('UIRoot')

local StartView = StartPanel.Create()
