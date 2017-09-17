local socket = require "socket"
 
-- begin
local udp = socket.udp()
udp:settimeout(0)
udp:setsockname('*', 12345)
local results = {
		{
			value = "",
			posX = x-Xincr,
			posY = initY + Yincr * 0,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} 
		},
		{
			value = "",
			posX = x-Xincr,
			posY = initY + Yincr * 1,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} 
		},
		{
			value = "",
			posX = x-Xincr,
			posY = initY + Yincr * 2,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} 
		},
		{
			value = "",
			posX = x-Xincr,
			posY = initY + Yincr * 3,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} 
		},
		{
			value = "",
			posX = x-Xincr,
			posY = initY + Yincr * 4,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} 
		},
		{
			value = "",
			posX = x-Xincr,
			posY = initY + Yincr * 5,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} 
		}
	}
 
-- We declare a whole bunch of local variables that we'll be using the in 
-- main server loop below. you probably recognise some of them from the
--client example, but you are also probably wondering what's with the fruity
-- names, 'msg_or_ip'? 'port_or_nil'?
-- 
-- well, we're using a slightly different function this time, you'll see when we get there.
local data, msg_or_ip, port_or_nil
local entity, cmd, parms
-- indefinite loops are probably not something you used to if you only 
-- know love, but they are quite common. and in fact love has one at its
-- heart, you just don't see it.
-- regardless, we'll be needing one for our server. and this little
-- variable lets us *stop* it :3
local running = true
 
-- the beginning of the loop proper...
print "Beginning server loop."
while running do
	
	data, msg_or_ip, port_or_nil = udp:receivefrom()
	if data then
		-- more of these funky match paterns!
		cmd, parms = data:match("^(%S*) (%S*) (.*)")
		if cmd == 'default' then
			amountOfTries = 0
			resultString = ""
			answer = ""
			for i = 1, 6, 1 do
				results[i].value = ""
				results[i].clicked = false
			end
		elseif cmd == 'setValue' then
			local amountOfTries, result = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
			assert(amountOfTries and result) -- validation is better, but asserts will serve.
			x, y = tonumber(amountOfTries), tonumber(result)
			results[amountOfTries] = result
		elseif cmd = 'update'
			for i = 1, 6, 1 do
				udp:sendto(string.format("%s  %d %d", 'updateRes', results[i], i), msg_or_ip,  port_or_nil)
			end
			udp:sendto(string.format("%s  %d", 'updateResStr', resultString), msg_or_ip,  port_or_nil)
		elseif cmd == 'quit' then
			--running = false;
		else
			print("unrecognised command:", cmd)
		end
	elseif msg_or_ip ~= 'timeout' then
		error("Unknown network error: "..tostring(msg))
	end
 
	socket.sleep(0.01)
end
 
print "Thank you."
 
-- and that the end of the udp server example.