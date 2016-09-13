
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")

require "config"
require "socket"
require "pack"
require "cocos.init"

cc.exports.utils = require "utils.init"
cc.exports.EventCenter = utils.event.EventCenter
cc.exports.EventDef = utils.event.EventDef

local function main()
    require("app.QpApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
