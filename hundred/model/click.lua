click = {X = 0, Y = 0}
function love.mousepressed(clickX, clickY, buttonClick, istouch)
	click.X = clickX
	click.Y = clickY
	if buttonClick == 1 then
		for name, s in pairs(screen.s) do
			if s.active then 
				for k,b in pairs(s.buttons) do
					if(click.inside(b)) then
						button:click(b)
						break
					end
				end 
			end
		end
		if click.insideField(answerField) then
			setDefaultValues()
		end
	end
end

function love.mousereleased(clickX, clickY, buttonClick, istouch)
	if buttonClick == 1 then
		for name, s in pairs(screen.s) do
			if s.active then 
				for k,b in pairs(s.buttons) do
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
	return click.X > button:get(name).X + screen:get(button:get(name).screen).X
		and click.X < button:get(name).X + screen:get(button:get(name).screen).X + button:get(name).width
		and click.Y > button:get(name).Y + screen:get(button:get(name).screen).Y
		and click.Y < button:get(name).Y + screen:get(button:get(name).screen).Y + button:get(name).height 
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