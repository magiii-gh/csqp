-----------------------------------------------------------------------------------------
---目前为了加快消息的分发效率，定义两个消息中心，
-----------------------------------------------------------------------------------------
require("src.app.common.event.event_def")

--- AI的事件中心
-----------------------------------------------------------------------------------------
AIEventCenter = class("AIEventCenter",require("src.app.common.event.event_center"))

-----------------------------------------------------------------------------------------


--- GUI的事件中心
-----------------------------------------------------------------------------------------
GUIEventCenter = class("GUIEventCenter",require("src.app.common.event.event_center"))
-----------------------------------------------------------------------------------------


---需要在切换场景的时候主动调用
game_event_center_clear = function ()
	AIEventCenter:clearAllListeners()
	GUIEventCenter:clearAllListeners()
end