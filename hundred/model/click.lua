click = {X = 0, Y = 0}
function love.mousepressed(clickX, clickY, buttonClick, istouch)
	click.X = clickX
	click.Y = clickY
	if buttonClick == 1 then
		for name, screen in pairs(screens) do
			if screen.draw then 
				for k,b in pairs(screen.buttons) do
					if(click.inside(b)) then
						button:click(b)
						break
					end
				end 
			end
		end
		--------------------------------------------------------------------------------------
		if screens.noNetWork.draw then
			if click.inside(returnButton) then
				noNetWork.draw = false
				menu.draw = true
			end
		end
		--------------------------------------------------------------------------------------
		if screens.wait.draw then
			if click.inside(returnButton) then
				wait.draw = false
				onlinePlay = false
				menu.draw = true
			end
		end
	end
end

function love.mousereleased(clickX, clickY, buttonClick, istouch)
	if buttonClick == 1 then
		for name, screen in pairs(screens) do
			if screen.draw then 
				for k,b in pairs(screen.buttons) do
					if(click.inside(b)) then
						button:release(b)
						break
					end
				end 
			end
		end
	end
end

function click.inside(name)
	if click.X > button:get(name).X
		and click.X < button:get(name).X + button:get(name).width
		and click.Y > button:get(name).Y
		and click.Y < button:get(name).Y + button:get(name).height 
		then
			return true
	end
	return false
end
function click.insideField(field)
	if click.X > field.X
		and click.X < field.X + field.width
		and click.Y > field.Y
		and click.Y < field.Y + field.height 
		then
			return true
	end
	return false
end