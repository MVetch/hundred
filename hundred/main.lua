love.window.setMode(1280, 720, {resizable = false, borderless=false})
--love.window.setMode(0, 0, {resizable = false, borderless=false})
utf8 = require "utf8"
socket = require "socket"
require 'json.json'
require "model/functions"
require "model/variables"
require "model/screens"
require "model/settings"
require "model/animation"
require "model/button"
require "model/drawable"
require "model/parcer"
require "model/timer"
require "model/scoreboard"
require "online/serverResponse"
require "initScreen"
require "game"
require "screens/background"
require "screens/coincount"
require "screens/scorebox"
require "screens/wait"
require "screens/noNetWork"
require "model/click"

function love.draw()
	--scoreboard:toString()
	for name, params in pairs(screen.s) do
		if screen:get(name).draw then screen:show(name) end
	end
end

function love.run()

	local dt = 0	

	if love.load then love.load(arg) end
 
	if love.timer then love.timer.step() end
 
	-- Main loop time.
	while true do
		-- Process events.
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
 
		-- Update dt, as we'll be passing it to update
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
 
		if love.timer then love.timer.sleep(1/60) end
	end
 
end