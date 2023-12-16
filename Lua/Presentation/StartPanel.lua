local UIUtils = require('Presentation.UIUtils')
local GameControllerPanel = require('Presentation.GameControllerPanel')

local M = {}

function M.Create()
    local t = {}
    
    t.panel = UIUtils.CreateView('StartView')
    
    t.startBtn = t.panel.transform:Find('StartGame').gameObject:GetComponent('Button')
    t.startBtn.onClick:AddListener(function() t:OnClickStart()  end)
    t.bg = ResMgr:InstantiatePrefab('Assets/Res/prefabs/MainBackground.prefab')
    
    function t:OnClickStart()
        t.panel:Close()
        GameObject.DestroyImmediate(t.bg)
        GameControllerPanel.Create()
    end
    
    return t
end

return M

