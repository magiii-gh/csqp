
local QpApp = class("QpApp", cc.load("mvc").AppBase)


function QpApp:run()

    self:addStoragePath()

      -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    math.randomseed(os.time())
    
    local scene = require("app.views.scenes.LoginScene"):new()
    scene:init()
    display.runScene(scene)
end

function QpApp:addStoragePath()
    local fileUtil =  cc.FileUtils:getInstance()
    local storagePath = fileUtil:getWritablePath() 
    --添加资源更新目录的搜索路径
    local paths = fileUtil:getSearchPaths()
    table.insert(paths, 1, storagePath .. "res/")
    table.insert(paths, 1, storagePath .. "src/")
    fileUtil:setSearchPaths(paths)
end

return QpApp
