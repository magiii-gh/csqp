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

	self._socket = utils.net.SocketTCP.new(self, "192.168.32.131", 20003, 3)
	self._socket:connect()

	EventCenter:register(EventDef.LOGON_RESULT, handler(self, self.handleLogonResult))
	EventCenter:dispatch(EventDef.LOGON_RESULT, "logon success")
	
end

function LoginScene:handleLogonResult(param)
	print("handleLogonResult: "..param)
end

function LoginScene:onEventClose()
	print("net close")
end

function LoginScene:onEventConnectFailure()
	print("net connect failure")
end

function LoginScene:onEventConnected()
	print("net connected")
	local msg = string.format("9001 99999 {'account':'%s'}", "test1")
	--local package = utils.bit.ByteArray.new():writeUShort(#msg):writeString(msg):getBytes()
	local package = string.pack("HA", #msg, msg)
	self._socket:send(package)
end

function LoginScene:onEventData(data)
	local buf = utils.bit.ByteArray.new()
		:writeBuf(data)
		:setPos(1)
	local size = buf:getLen()
	while (size > 2) do
		local package_size = buf:readUShort()
		if package_size > buf:getAvailable() then
			break
		end
		local package = buf:readString(package_size)
		print(package_size, package)

		size = size - 2
		size = size - package_size
	end
end

return LoginScene