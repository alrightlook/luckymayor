local M = {}

function M.CreateView(name)
    local t = {}
    
    t.gameObject = ResMgr:InstantiateUI('Assets/Res/prefabs/ui/'..name..'.prefab', UIRoot.transform)
    t.transform = t.gameObject.transform
    
    function t:Close()
        CS.UnityEngine.GameObject.DestroyImmediate(t.gameObject)
    end
    
    return t
end

return M