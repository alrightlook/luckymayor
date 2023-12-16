local UIUtils = require('Presentation.UIUtils')
local ChooseCityzen = require('Presentation.ChooseCityzen')
local Event = require('core.Event')
local MSG = Event.MSG

local M = {}

function M.SetProduct(products, product_id, slot_index, num)
    local p = products[slot_index]
    if product_id == -1 then
        p:GetChild(0).gameObject:SetActive(false)
        p:GetChild(1).gameObject:SetActive(false)
        return
    else
        local icon = p:GetChild(0).gameObject:GetComponent("Image")
        local txtnum = p:GetChild(1).gameObject:GetComponent("Text")
        icon.sprite = ResMgr:LoadSprite('Assets/Res/Items/item_'..product_id..'.png', p)
        txtnum.text = tostring(num)
    end
end

function M.Create()
    local t = {}

    t.panel = UIUtils.CreateView('GameControllPanel')
    local transform = t.panel.transform
    
    local Cityzens = transform:Find('Cityzens')
    local products = transform:Find('Products')
    t.group = {}
    
    t.products = {}
    
    t.btnNextDay = transform:Find('Bottom/NextDay').gameObject:GetComponent('Button')
    t.btnNextDay.onClick:AddListener(function() t:OnClickNextDay()  end)
    
    t.LevelGoalCoin = transform:Find('LevelObjective/Num').gameObject:GetComponent('Text')
    t.NowCoin = transform:Find('NowGold/Num').gameObject:GetComponent('Text')
    
    for i = 0, 3 do
        t.group[i + 1] = Cityzens:GetChild(i)
    end

    for i = 0, 6 do
        t.products[i + 1] = products:GetChild(i)
    end
    
    function t:SetActiveCityzens(group, index, cityzenid)
        local transGroup = self.group[group]
        local slot = transGroup:GetChild(index - 1)
        
        local avatar = ResMgr:InstantiateUI('Assets/Res/prefabs/ui/cityzens/'..'Unit'..cityzenid..'.prefab', slot)
        avatar.transform.localScale = 0.4 * CS.UnityEngine.Vector3.one
        avatar.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
    end
    
    function t:OnClickNextDay()
        Event.Dispatch(MSG.NextDay)
    end
    
    Event.Listen(MSG.ChooseCityzen, function(data)
        ChooseCityzen.Create(data)
    end)

    Event.Listen(MSG.SetProduct, function(data)
        M.SetProduct(t.products, data.item_id, data.position, data.count)
    end)

    Event.Listen(MSG.SetActiveCityzen, function(data)
        t:SetActiveCityzens(data.group, data.position, data.id)
    end)
    
    Event.Listen(MSG.SetLevelGoal, function(data) t.LevelGoalCoin.text = tostring(data)  end)
    Event.Listen(MSG.SetLevelCoin, function(data) t.NowCoin.text = tostring(data)  end)
    
    Event.Dispatch(MSG.InitDesk)

    return t
end

return M
