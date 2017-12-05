screen:new("settings", {
	X = x/3,
	Y = y/4,
	w = x/3,
	h = y/2,
	z = 2
})

button:add("closeSettings", {
	X = screen:get("settings").w-titleFont:getHeight("a"),
	width = titleFont:getHeight("a"),
	height = titleFont:getHeight("a"),
	value = "x",
	color = {255, 0, 0},
	screen = "settings",
	font = titleFont,
	onclick = function()
		screen:get("settings").draw = false
		screen:get("settings").active = false
		screen:get("game").active = true
	end
})

button:add("soundSwitch", {
	X = titleFont:getWidth("Sound") + 10,
	Y = titleFont:getHeight("a") * 2,
	width = titleFont:getHeight("a"),
	height = titleFont:getHeight("a"),
	value = "",
	color = {255, 0, 0},
	backgroundImage = tern(settings:get("soundOn"), soundOnPic, soundOffPic),
	screen = "settings",
	font = titleFont,
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

-- button:add("skin", {
-- 	X = titleFont:getWidth("Sound") + 10,
-- 	Y = titleFont:getHeight("a") * 4,
-- 	width = titleFont:getHeight("a"),
-- 	height = titleFont:getHeight("a"),
-- 	value = "",
-- 	color = {255, 0, 0},
-- 	backgroundImage = skinTable[settings:get("skin")].nextSkin,
-- 	screen = "settings",
-- 	font = titleFont,
-- 	onclick = function()
-- 		if skinTable[settings.skin].sound:isPlaying() then
-- 			skinTable[settings:get("skin")].sound:stop()
-- 		end
-- 		settings:set("skin", settings:get("skin") + 1)
-- 		if settings:get("skin") > table.getn(skinTable) then
-- 			settings:set("skin", 1)
-- 		end
-- 		button:get("skin").backgroundImage = skinTable[settings.skin].nextSkin
-- 	end
-- })

slider:add("skin", {
	slideCount = 5
})

for k,v in pairs(skin.s) do
	slide:add(k, {
		img = v.img,
		onclick = function()
			skin:get(settings:get("skin")).sound:stop()
			settings:set("skin", k)
		end
	})
end

function screen.s.settings:show()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", 0, 0, self.w, self.h)
	love.graphics.setColor(0,0,0)
	title = "Settings"
	love.graphics.setFont(titleFont)
	love.graphics.print(title, self.w/2 - titleFont:getWidth(title)/2, 10)
	love.graphics.print("Sound", 5, titleFont:getHeight(title) * 2)
	love.graphics.print("Skin", 5, titleFont:getHeight(title) * 4)
	slider:draw("skin", 0, titleFont:getHeight(title) * 6, self.w, 50)
end