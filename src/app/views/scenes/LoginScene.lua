local LoginScene = class("LoginScene", function ( )
	 return display.newScene("BaseScene") end)

function LoginScene:init()
    -- add background image
    display.newSprite("helloworld.png")
        :move(display.center)
        :addTo(self)

    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)
	
	
	--[[	
	local __pack = string.pack("<bihP2", 0x59, 11, 1101, "", "你好")
	local __ba1 = utils.bit.ByteArray.new()
		:writeBuf(__pack)
		:setPos(1)
	print("ba1.len:", __ba1:getLen())
	print("ba1.readByte:", __ba1:readByte())
	print("ba1.readInt:", __ba1:readInt())
	print("ba1.readShort:", __ba1:readShort())
	print("ba1.readString:", __ba1:readStringUShort())
	print("ba1.readString:", __ba1:readStringUShort())
	print("ba1.available:", __ba1:getAvailable())
	print("ba1.toString(16):", __ba1:toString(16))
	print("ba1.toString(10):", __ba1:toString(10))
	]]--

	self._netdata = utils.bit.ByteArray.new()
	self._socket = utils.net.SocketTCP.new(self, "192.168.32.131", 20003, 3)
	self._socket:connect()

	if self._handleLogonResult == nil then
		self._handleLogonResult  = handler(self, self.onLogonResult)
		EventCenter:register(EventDef.LOGON_RESULT, handler(self, self.onLogonResult))
	end
	EventCenter:dispatch(EventDef.LOGON_RESULT, "logon success")

	self:enableNodeEvents()
	
end

function LoginScene:onCleanup()
	print("onExit")
	if self._handleLogonResult ~= nil then
		EventCenter:unregister(EventDef.LOGON_RESULT, self._handleLogonResult)
	end
end

function LoginScene:onLogonResult(param)
	print("onLogonResult: "..param)
end

function LoginScene:onNetClose()
	print("net close")
end

function LoginScene:onNetConnectFailure()
	print("net connect failure")
end

function LoginScene:onNetConnected()
	print("net connected")
	local msg = string.format("9001 99999 {'account':'%s'}", "test1")
	--local package = utils.bit.ByteArray.new():writeUShort(#msg):writeString(msg):getBytes()
	local package = string.pack("HA", #msg, msg)
	self._socket:send(package)
end

function LoginScene:onNetData(data)
	self._netdata:writeBuf(data):setPos(1)
	local size = self._netdata:getAvailable()
	print(size)
	while (size > 2) do
		local package_size = self._netdata:readUShort()
		if self._netdata:getAvailable() < package_size then	--包不完整
			local pos = self._netdata:getPos()
			self._netdata:setPos(pos-2)
			break
		end
		local package = self._netdata:readString(package_size)
		print(package_size, package)

		size = size - 2
		size = size - package_size
	end
	--把剩余数据移至buffer头部
	if self._netdata:getAvailable() > 0 then
		print("roll", size)
		local buf = self._netdata:readBuf(size)
		self._netdata = utils.bit.ByteArray.new():writeBuf(buf)
	end
end

return LoginScene