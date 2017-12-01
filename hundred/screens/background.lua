screen:new("background", {
	draw = true,
})
function screen.s.background.show()
	love.graphics.setFont(buttonFont)
	love.graphics.setColor(0,0,0, 100)
	topLeft("need for spin\npre-alpha " .. version .. "\n" .. timer:get())
	button:draw("close")
	button:draw("scorebox")
	button:draw("settings")
end

button:add("close", {
	X = x-button.default.width/2,
	width = button.default.width/2,
	value = "x",
	color = {255, 0, 0},
	onclick = function()
		love.event.quit()
	end
})

button:add("scorebox", {
	X = x-5.5*button.default.width/2,
	width = button.default.width/2,
	value = "S",
	color = {255, 0, 0},
	onclick = function()
		--screens.game.draw = not screens.game.draw
		screen:get("scorebox").draw = not screen:get("scorebox").draw
		--scoreboard:show()
	end
})

button:add("spincoin", {
	X = x-7*button.default.width/2,
	width = button.default.width/2,
	value = "",
	color = {255, 0, 0},
	backgroundImage = spincoinPic,
	onclick = function()
		--screens.game.draw = not screens.game.draw
		screen:get("scorebox").draw = not screen:get("scorebox").draw
		--scoreboard:show()
	end
})

button:add("settings", {
	X = x-9.5*button.default.width/2,
	width = button.default.width/2,
	value = "",
	color = {255, 0, 0},
	backgroundImage = settingsPic,
	onclick = function()
		screen:get("settings").draw = not screen:get("settings").draw
	end
})