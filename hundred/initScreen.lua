love.graphics.setBackgroundColor(BackgroundColor)

button:add("close", {
	X = x-button.width/2,
	width = button.width/2,
	value = "x",
	color = {255, 0, 0},
	onclick = function()
		love.event.quit()
	end
})

-- button:add("playOffline", {
-- 	X = x/2 - getPercent(x, 41.40625)/2,
-- 	Y = y/2 + button.height,
-- 	width = getPercent(x, 41.40625),
-- 	value = "Play offline",
-- 	onclick = function()
-- 		menu.draw = false
-- 		onlinePlay = false
-- 		game.draw = true
-- 	end
-- })

-- button:add("playOnline", {
-- 	X = x/2 - getPercent(x, 41.40625)/2,
-- 	Y = y/2 + button.height,
-- 	width = getPercent(x, 41.40625),
-- 	value = "Play online",
-- 	textColorClicked = {255,0,0},
-- 	onclick = function()
-- 		menu.draw = false
-- 		onlinePlay = true
-- 		if myId then
-- 			udp:send(string.format('%s %d', 'search', myId))
-- 			wait.draw = true
-- 		else
-- 			noNetWork.draw = true
-- 		end
-- 	end
-- })

-- button:add("return", {
-- 	X = getPercent(x, 0.78125),
-- 	Y = getPercent(x, 0.78125),
-- 	width = button.width * 5,
-- 	value = "Return",
-- 	onclick = function()
-- 		noNetWork.draw = false
-- 		menu.draw = true
-- 	end
-- })

function menu.show()
	button:draw("playOffline")
	button:draw("playOnline")
end