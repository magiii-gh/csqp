--[[
SocketTCP lua
]]
local SOCKET_TICK_TIME = 0.1 			-- check socket data interval
local SOCKET_RECONNECT_TIME = 5			-- socket reconnect try interval
local SOCKET_CONNECT_FAIL_TIMEOUT = 3	-- socket failure timeout

local STATUS_CLOSED = "closed"
local STATUS_NOT_CONNECTED = "Socket is not connected"
local STATUS_ALREADY_CONNECTED = "already connected"
local STATUS_ALREADY_IN_PROGRESS = "Operation already in progress"
local STATUS_TIMEOUT = "timeout"

local socket = import("socket")

local SocketTCP = class("SocketTCP")

SocketTCP._VERSION = socket._VERSION
SocketTCP._DEBUG = socket._DEBUG

function SocketTCP.getTime()
	return socket.gettime()
end

function SocketTCP:ctor(delegate_, host_, port_, retryConnectWhenFailure_)
    self._delegate = delegate_
	self._host = host_
    self._port = port_
	self._tickScheduler = nil			-- timer for data
	self._reconnectScheduler = nil		-- timer for reconnect
	self._connectTimeTickScheduler = nil	-- timer for connect timeout
	self._name = 'SocketTCP'
	self._tcp = nil
	self._isRetryConnect = retryConnectWhenFailure_
	self._isConnected = false
end

function SocketTCP:setDelegate(delegate_)
	self._delegate = delegate_
end

function SocketTCP:setName( name_ )
	self._name = name_
	return self
end

function SocketTCP:setTickTime(time_)
	SOCKET_TICK_TIME = time_
	return self
end

function SocketTCP:setReconnTime(time_)
	SOCKET_RECONNECT_TIME = time_
	return self
end

function SocketTCP:setConnFailTime(time_)
	SOCKET_CONNECT_FAIL_TIMEOUT = time_
	return self
end

function SocketTCP:connect(host_, port_, retryConnectWhenFailure_)
	if host_ then self._host = host_ end
	if port_ then self._port = port_ end
	if retryConnectWhenFailure_ ~= nil then self._isRetryConnect = retryConnectWhenFailure_ end

	self.tcp = socket.tcp()
	self.tcp:settimeout(0)

	local function _checkConnect()
		local succ = self:_connect()
		if succ then
			self:_onConnected()
		end
		return succ
	end

	if not _checkConnect() then
		-- check whether connection is success
		-- the connection is failure if socket isn't connected after SOCKET_CONNECT_FAIL_TIMEOUT seconds
		local connectTimeTick = function ()
			--print("%s.connectTimeTick", self.name)
			if self._isConnected then return end
			self._waitConnect = self._waitConnect or 0
			self._waitConnect = self._waitConnect + SOCKET_TICK_TIME
			if self._waitConnect >= SOCKET_CONNECT_FAIL_TIMEOUT then
				self._waitConnect = nil
				self:close()
				self:_connectFailure()
			end
			_checkConnect()
		end
		self._connectTimeTickScheduler = scheduler.scheduleGlobal(connectTimeTick, SOCKET_TICK_TIME)
	end
end

function SocketTCP:send(data_)
	if not self._isConnected then
		print(self._name .. " is not connected.")
		return
	end
	self.tcp:send(data_)
end

function SocketTCP:close( ... )
	--print("%s.close", self.name)
	self.tcp:close();
	if self._connectTimeTickScheduler then scheduler.unscheduleGlobal(self._connectTimeTickScheduler) end
	if self._tickScheduler then scheduler.unscheduleGlobal(self._tickScheduler) end

	if self._delegate then
		self._delegate:onEventClose()
	end
end

-- disconnect on user's own initiative.
function SocketTCP:disconnect()
	self:_disconnect()
	self._isRetryConnect = false -- initiative to disconnect, no reconnect.
end

--------------------
-- private
--------------------

--- When connect a connected socket server, it will return "already connected"
-- @see: http://lua-users.org/lists/lua-l/2009-10/msg00584.html
function SocketTCP:_connect()
	local succ, status = self._tcp:connect(self._host, self._port)
	-- print("SocketTCP._connect:", __succ, __status)
	return succ == 1 or status == STATUS_ALREADY_CONNECTED
end

function SocketTCP:_disconnect()
	self._isConnected = false
	self._tcp:shutdown()
	if self._delegate then
		self._delegate:onEventClosed()
	end
	
end

function SocketTCP:_onDisconnect()
	--print("%s._onDisConnect", self.name);
	self._isConnected = false
	if self._delegate then
		self._delegate:onEventClosed()
	end
	self:_reconnect();
end

-- connecte success, cancel the connection timerout timer
function SocketTCP:_onConnected()
	--print("%s._onConnectd", self.name)
	self.isConnected = true
	if self._delegate then
		self._delegate:onEventConnected()
	end
	if self._connectTimeTickScheduler then scheduler.unscheduleGlobal(self._connectTimeTickScheduler) end

	local tick = function()
		while true do
			-- if use "*l" pattern, some buffer will be discarded, why?
			local body, status, partial = self.tcp:receive("*a")	-- read the package body
			--print("body:", __body, "__status:", __status, "__partial:", __partial)
    	    if status == STATUS_CLOSED or status == STATUS_NOT_CONNECTED then
		    	self:close()
		    	if self.isConnected then
		    		self:_onDisconnect()
		    	else
		    		self:_connectFailure()
		    	end
		   		return
	    	end
		    if 	(body and string.len(body) == 0) or
				(partial and string.len(partial) == 0)
			then return end
			if body and partial then body = body .. partial end
			if self._delegate then
				self._delegate:onEventData(partial or body, partial, body)
			end 
		end
	end

	-- start to read TCP data
	self._tickScheduler = scheduler.scheduleGlobal(tick, SOCKET_TICK_TIME)
end

function SocketTCP:_connectFailure(status)
	--print("%s._connectFailure", self.name);
	if self._delegate then
		self._delegate:onEventConnectFailure()
	end 
	self:_reconnect();
end

-- if connection is initiative, do not reconnect
function SocketTCP:_reconnect(immediately_)
	if not self._isRetryConnect then return end
	print("%s._reconnect", self.name)
	if immediately_ then self:connect() return end
	if self._reconnectScheduler then scheduler.unscheduleGlobal(self._reconnectScheduler) end
	local doReConnect = function ()
		self:connect()
	end
	self._reconnectScheduler = scheduler.performWithDelayGlobal(doReConnect, SOCKET_RECONNECT_TIME)
end

return SocketTCP