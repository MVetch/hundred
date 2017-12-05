screen:new("background", {
	draw = true,
	active = true
})
function screen.s.background.show()
	love.graphics.setFont(buttonFont)
	love.graphics.setColor(0,0,0, 100)
	topLeft("need for spin" .. "\nFPS:" .. love.timer.getFPS() .. "\n" .. timer:get())
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
	X = x-2.5*button.default.width/2,
	width = button.default.width/2,
	value = "S",
	color = {255, 0, 0},
	onclick = function()
		screen:get("scorebox").draw = not screen:get("scorebox").draw
		screen:get("scorebox").active = not screen:get("scorebox").active
	end
})

button:add("settings", {
	X = x-4*button.default.width/2,
	width = button.default.width/2,
	value = "",
	color = {255, 0, 0},
	backgroundImage = settingsPic,
	onclick = function()
		screen:get("settings").draw = not screen:get("settings").draw
		screen:get("settings").active = not screen:get("settings").active
		screen:get("game").active = not screen:get("game").draw
	end
})