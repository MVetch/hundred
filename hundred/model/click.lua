click = {X = 0, Y = 0}
function love.mousepressed(clickX, clickY, buttonClick, istouch)
	click.X = clickX
	click.Y = clickY
	if buttonClick == 1 then
		--------------------------------------------------------------------------------------
		if game.draw then
			for k,b in pairs(game.buttons) do
				if(click.inside(b)) then
					button:click(b)
					break
				end
			end
			-- if click.inside(answerField) and answer == winAnswer then
			-- 	setDefaultValues()
			-- end
		end
		--------------------------------------------------------------------------------------
		if menu.draw then
			for k,b in pairs(menu.buttons) do
				if(click.inside(b)) then
					button:click(b)
					break
				end
			end
		end
		--------------------------------------------------------------------------------------
		if noNetWork.draw then
			if click.inside(returnButton) then
				noNetWork.draw = false
				menu.draw = true
			end
		end
		--------------------------------------------------------------------------------------
		if wait.draw then
			if click.inside(returnButton) then
				wait.draw = false
				onlinePlay = false
				menu.draw = true
			end
		end
		if click.inside("close") then
			button:click("close")
		end
	end
end

function love.mousereleased(x, y, buttonClick, istouch)
	if buttonClick == 1 then
		--------------------------------------------------------------------------------------
		if game.draw then
			for k,b in pairs(game.buttons) do
				if(click.inside(b)) then
					button:release(b)
				end
			end
			if click.insideField(answerField) and answer == winAnswer then
				setDefaultValues()
			end
		end
		--------------------------------------------------------------------------------------
		if menu.draw then
			for b in menu.buttons do
				if(click.inside(b)) then
					button:release(b)
				end
			end
		end
		--------------------------------------------------------------------------------------
		if noNetWork.draw then
			if click.inside(returnButton) then
				noNetWork.draw = false
				menu.draw = true
			end
		end
		--------------------------------------------------------------------------------------
		if wait.draw then
			if click.inside(returnButton) then
				wait.draw = false
				onlinePlay = false
				menu.draw = true
			end
		end
		if click.inside("close") then
			button:release("close")
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