local UIUtils = require('Presentation.UIUtils')
local Event = require('core.Event')
local MSG = Event.MSG

local M = {}

function M.Create(data)
    local t = {}
    t.panel = UIUtils.CreateView('ChooseCityzen')
    local transform = t.panel.transform   
    
    t.bg = transform:Find('bg')
    for i = 1, 3 do
        local panel = t.bg:GetChild(i - 1)
        local btn = panel:GetChild(0).gameObject:GetComponent('Button')
        local title = panel:GetChild(1).gameObject:GetComponent('Text')
        local desc = panel:GetChild(2).gameObject:GetComponent('Text')
        
        title.text = data[i].name
        desc.text = data[i].desc
        
        local index = i
        btn.onClick:AddListener(function() 
            t.panel:Close()
            Event.Dispatch(MSG.ChooseCityzenResult, index)
        end)
    end
    
    return t
end

return M