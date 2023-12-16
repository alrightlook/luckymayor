local Event = require('core.Event')
local MSG = Event.MSG

--刷新桌面上第几组，第几个位置上的人物
function RefreshActiveCityzens(group, position, cityzenId)
    local data = {
        group = group,
        position = position,
        id = cityzenId,  -- 这个ID是表现层的ID 对应不同的人物形象, 并无逻辑意义
    }
    Event.Dispatch(MSG.SetActiveCityzen, data)
end

--设置桌面上7个位置的产品图标和数量
function SetProduct(pos, item_id, count) 
    local data = {
        position = pos, --1到7个槽位
        item_id = item_id, --0到39 一共40个item
        count = count, --有多少个产品数量
    }
    Event.Dispatch(MSG.SetProduct, data)
end

--通知表现层弹出一个选择市民的UI界面出来，参数可扩展
function ChooseCityzen(data) 
    Event.Dispatch(MSG.ChooseCityzen, data)
end

function SetLevelGoal(coin) 
    Event.Dispatch(MSG.SetLevelGoal, coin)
end

function SetTotalCoin(coin) 
    Event.Dispatch(MSG.SetLevelCoin, coin)
end

--初始状态的桌面, 暂时没有参数, 后面会考虑加上玩家存档
function InitDesk()
    --Eg:
    --随机桌面市民
    for group = 1, 4 do --桌面上有四个组
        for pos = 1, 5 do --每个组有5个位子
            --每个位子就随机一个1~ 10 的村民ID吧
            local id = math.random(1, 10)
            RefreshActiveCityzens(group, pos, id)
        end
    end

    --随机桌面产物
    for i = 1, 7 do
        local id = math.random(0, 39)
        local count = 1
        SetProduct(i, id, count)
    end
    
    SetLevelGoal(25)
    SetTotalCoin(0)
end

--玩家按下了NextDay按钮了
function OnPlayerNextDay()
    --可以在这里组织随机Roll的市民数据传给ChooseCityzen 这里我就暂时hard coded了
    local tmp = {}

    tmp[1] = {
        name = '小矮人',
        desc = '这是一段这个市民的介绍文字'
    }
    tmp[2] = {
        name = '小矮人',
        desc = '这是一段这个市民的介绍文字'
    }
    tmp[3] = {
        name = '小矮人',
        desc = '这是一段这个市民的介绍文字'
    }
    ChooseCityzen(tmp)
end

--玩家选择了三张卡中的一张 index 表示1，2，3
function OnPlayerChooseCityzen(index)
    print('Player Choose '..index)
end

--下面是监听事件
Event.Listen(MSG.InitDesk, InitDesk)
Event.Listen(MSG.NextDay, OnPlayerNextDay)
Event.Listen(MSG.ChooseCityzenResult, OnPlayerChooseCityzen)
