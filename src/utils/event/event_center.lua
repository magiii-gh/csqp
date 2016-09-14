----------------------------------------------
-------------------通知中心-------------------
--事件中心的基类
----------------------------------------------

--- 通知中心
-- @module EventCenter
local EventCenter = class("EventCenter") -- #table

--- 事件侦听器
-- @field #table
EventCenter._listeners = {}

--- 注册事件
-- @param #NoticeCenter self
EventCenter.register = function(self, name, func, priority, active)
    if name == nil or func == nil then
        print("error ! name or func can't == nil ")
        return 
    end
    
    --先注销
    self:unregister(name, func)
        
    priority = priority or 0
    --默认是激活
    active = active or true  
    
    self._listeners[name] = self._listeners[name] or {}
    local i = 1
    for _, listener in ipairs(self._listeners[name]) do
        if listener.priority > priority then
            break
        end
        i = i + 1
    end
    table.insert(self._listeners[name], i, {func = func, priority = priority, active = active})
    
    
end

--- 注销
-- @param #NoticeCenter self
EventCenter.unregister = function(self, name, func)
    if self._listeners[name] then
        for i, listener in ipairs(self._listeners[name]) do
            if listener.func == func then
                --print("unregister event = " .. name)
                table.remove(self._listeners[name], i)
                break
            end
        end
        if 0 == #self._listeners[name] then
            self._listeners[name] = nil
        end
    end
end
	

--- 分发事件
-- @param #EventCenter self
EventCenter.dispatch = function(self, name, ...)
    local exist = false
    if self._listeners[name] then
        local listeners = clone(self._listeners[name]) 
        for i, listener in ipairs(listeners) do
            exist = true
            if listener.active then
                listener.func(...)
            else
                --print("event ".. name .. " is not active")
            end
        end
    end
    
    if not exist then
        --print("event ".. name .. " not be deal with!")
    end
end

----设置事件的状态
EventCenter.activeEvent = function (self, name, active)
	if self._listeners[name] then
        for __index, listens in pairs(self._listeners[name]) do
            listens.active = active
	   end
	end
end


--- 清除所有监听器
-- @param #NoticeCenter self
EventCenter.clearAllListeners = function(self)
    self._listeners = {}
end

return EventCenter