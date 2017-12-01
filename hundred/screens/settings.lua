screen:new("settings", {
	X = x/3,
	Y = y/4,
	w = x/3,
	h = y/2,
	z=2
})

button:add("soundSwitch", {
	X = screen:get("settings").w-2.5*button.default.width/2,
	width = button.default.width/2,
	value = "",
	color = {255, 0, 0},
	backgroundImage = tern(settings:get("soundOn"), soundOnPic, soundOffPic),
	screen = "settings",
	onclick = function()
		if settings.soundOn then 
			button:get("soundSwitch").backgroundImage = soundOffPic
			love.audio.pause()
		else
			button:get("soundSwitch").backgroundImage = soundOnPic
		end
		settings:set("soundOn", not settings:get("soundOn"))
	end
})

button:add("closeSettings", {
	X = screen:get("settings").w-button.default.width/2,
	width = button.default.width/2,
	value = "x",
	color = {255, 0, 0},
	screen = "settings",
	onclick = function()
		screen:get("settings").draw = false
	end
})

function screen.s.settings:show()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", 0, 0, self.w, self.h)
	love.graphics.setColor(0,0,0)
	title = "Settings"
	love.graphics.setFont(titleFont)
	love.graphics.print(title, self.w/2 - titleFont:getWidth(title)/2, 10)
	love.graphics.print("Sound", 5, titleFont:getHeight(title) * 2)
	love.graphics.print("Skin", 5, titleFont:getHeight(title) * 3)
	button:draw("soundSwitch")
	button:draw("closeSettings")
end