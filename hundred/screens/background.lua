function screen.s.background.show()
	love.graphics.setFont(buttonFont)
	love.graphics.setColor(0,0,0, 100)
	topLeft("need for spin\npre-alpha " .. version .. "\n" .. timer:get())
	button:draw("close")
	button:draw("soundSwitch")
	button:draw("scorebox")
end

button:add("close", {
	X = x-button.width/2,
	width = button.width/2,
	value = "x",
	color = {255, 0, 0},
	onclick = function()
		love.event.quit()
	end
})
button:add("soundSwitch", {
	X = x-2.5*button.width/2,
	width = button.width/2,
	value = "",
	color = {255, 0, 0},
	backgroundImage = tern(settings:get("soundOn"), soundOnPic, soundOffPic),
	onclick = function()
		if settings.soundOn then 
			button:get("soundSwitch").backgroundImage = soundOffPic
			love.audio.stop()
		else
			button:get("soundSwitch").backgroundImage = soundOnPic
		end
		settings:set("soundOn", not settings:get("soundOn"))
	end
})

button:add("scorebox", {
	X = x-5.5*button.width/2,
	width = button.width/2,
	value = "S",
	color = {255, 0, 0},
	onclick = function()
		--screens.game.draw = not screens.game.draw
		screen.s.scorebox.draw = not screen.s.scorebox.draw
		--scoreboard:show()
	end
})

button:add("spincoin", {
	X = x-7*button.width/2,
	width = button.width/2,
	value = "",
	color = {255, 0, 0},
	backgroundImage = spincoinPic,
	onclick = function()
		--screens.game.draw = not screens.game.draw
		screens.scorebox.draw = not screens.scorebox.draw
		--scoreboard:show()
	end
})