local LoginScene = class("LoginScene", function ( )
	 return display.newScene("BaseScene") end)

function LoginScene:init()
    -- add background image
    display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)
	
	
		
	local __pack = string.pack("<bihP2", 0x59, 11, 1101, "", "ÖÐÎÄ")
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
	
end

return LoginScene