local M = {}

function M.Create()
    local t = {}
    t.bg = ResMgr:InstantiatePrefab('Assets/Res/prefabs/GamePanel.prefab')
    
    return t
end

return M