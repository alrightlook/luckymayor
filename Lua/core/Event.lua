--这个模块用来维护消息系统
local M = {}

M.eventList = {}

M.MSG = {
    InitDesk = 1, --表现层通知逻辑层初始化桌台上的市民
    NextDay = 2, --玩家按下NextDay按钮
    ChooseCityzen = 3, --逻辑层通知表现打开一个选择市民的面板
    ChooseCityzenResult = 4, --表现层通知逻辑层玩家选择了哪个市民
    SetProduct = 5,   --逻辑层改变表现层的产物列表
    SetLevelGoal = 6, --逻辑层告知表现层这一关的通关目标是多少金币
    SetLevelCoin = 7, --逻辑层通知修改累计获得了多少金币
    SetActiveCityzen = 8, --逻辑刷新桌面上的市民
}

--监听某个感兴趣的消息
function M.Listen(msg, func)
    if not M.eventList[msg]  then
        M.eventList[msg] = {}
    end
    
    table.insert(M.eventList[msg], func)
end

--广播某条消息
function M.Dispatch(msg, params)
    if M.eventList[msg] then
        local funcs = M.eventList[msg]
        for _, v in pairs(funcs) do
            v(params)
        end
    end
end

return M