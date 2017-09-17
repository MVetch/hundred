address, port = "localhost", 12345
updaterate = 0.1
t=0
udp = socket.udp()
udp:settimeout(0)
udp:setpeername(address, port)
udp:send('connect', 0)

function love.update(deltatime)
	t = t + deltatime -- increase t by the deltatime
	if game.draw and onlinePlay then
		if t > updaterate then
			udp:send(string.format('%s %d', 'update', roomId))
			t=t-updaterate -- set t for the next round
		end
	end
	repeat
		data, msg = udp:receive()
		if data then
			if (data:match("^(%S*) (.*)")) then
				cmd, parms = data:match("^(%S*) (.*)")
			else 
				cmd = data:match("^(%S*)")
			end
			--------------------------------------------------
			if cmd == 'updateRes' then
				local index, res = parms:match("^(%-?[%d.e]*) (%S*)")
				if res then
					index = tonumber(index)
					results[index].value = res
				end
			--------------------------------------------------
			elseif cmd == 'connected' then
				local res = parms:match("^(%-?[%d.e]*)")
				myId = tonumber(res)
				online = true
			--------------------------------------------------
			elseif cmd == 'notfound' then
				if onlinePlay then
					udp:send(string.format('%s %d', 'search', myId))
				end
			--------------------------------------------------
			elseif cmd == 'found' then
				local res = parms:match("^(%-?[%d.e]*)$")
				udp:send(string.format('%s %d %d','createRoom', myId, res))
			--------------------------------------------------
			elseif cmd == 'roomCreated' then
				local res = parms:match("^(%-?[%d.e]*)$")
				roomId = tonumber(res)
				wait.draw = false
				game.draw = true
			--------------------------------------------------
			else
				resultString = "unrecognised command:" .. cmd
			end
		elseif msg ~= 'timeout' then 
			resultString = "Network error: "..tostring(msg)
		end
	until not data
end