love.window.setMode(1280, 720, {
	resizable = false, 
	borderless=false,
	vsync = false
})
--love.window.setMode(0, 0, {resizable = false, borderless=false})
utf8 = require "utf8"
socket = require "socket"
require 'json.json'
require 'functions'
require 'variables'
local dirs = {
	"model",
	"screens",
	"online"
}
for i=1,table.getn(dirs),1 do
	local files = love.filesystem.getDirectoryItems(dirs[i])
	for k, file in ipairs(files) do
		require(dirs[i] .. "/" .. file:sub(1,-5))
	end
end
require "initScreen"
require "game"

function hovered(X, Y, w, h)
	return cursor.x > X
		and cursor.x < X + w
		and cursor.y > Y
		and cursor.y < Y + h
end

function love.draw()
	cursor.x, cursor.y = love.mouse.getPosition()
	for name, params in screen:orderBy("z") do
		if screen:get(name).draw then screen:show(name) end
	end
end

function love.run()

	local dt = 0	

	if love.load then love.load(arg) end
 
	if love.timer then love.timer.step() end
 
	while true do
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if online then
						udp:send(string.format('%s %d', 'disconnect', myId))
					end
					if not love.quit or not love.quit() then
						return a
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
 
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end
 
		-- Call update and draw
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
 
		if love.graphics and love.graphics.isActive() then
			love.graphics.clear(love.graphics.getBackgroundColor())
			love.graphics.origin()
			if love.draw then love.draw() end
			love.graphics.present()
		end
 
		if love.timer then love.timer.sleep(1/65) end
	end
 
end