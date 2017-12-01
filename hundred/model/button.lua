button = {
	b={},
	default = {
		X = 0,
		Y = 0,
		value = "Push!",
		rx = 10,
		ry = 10,
		segments = 40,
		shadowX = 3,
		shadowY = 3,
		incrX = 0,
		incrY = 0,
		onclick = function() end,
		onhover = function() end,
		width = getPercent(x, 7.8125),
		height = getPercent(x, 3.90625),
		color = {123,237,203},
		font = love.graphics.newFont("fonts/joystix monospace.ttf", fontSize),
		font1 = love.graphics.newFont("fonts/joystix monospace.ttf", fontSize + 2),
		fontColor = BackgroundColor,
		screen = "background"
	}
}

function button:click(name)
	button:get(name).incrX = button:get(name).incrX + button:get(name).shadowX - 1
	button:get(name).incrY = button:get(name).incrY + button:get(name).shadowY - 1
end

function button:release(name)
	button:get(name).incrX = button:get(name).incrX - button:get(name).shadowX + 1
	button:get(name).incrY = button:get(name).incrY - button:get(name).shadowY + 1
	button:get(name).onclick()
end

function button:add(name, params, toscreen)
	self.b[name] = {}
	if not params then params = {} end
	for k,v in pairs(self.default) do
		button:get(name)[k] = params[k] or v
	end
	self:get(name).backgroundImage = params.backgroundImage
	table.insert(screen:get(self:get(name).screen).buttons, name)
end

function button:delete(name)
	table.remove(self.b, name)
	table.remove(game.buttons, name)
end

function button:draw(name)
	if not self:exists(name) then
		error("button " .. name .. " doesn't exist.")
	end
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle(
		"fill", 
		button:get(name).X+button:get(name).shadowX, 
		button:get(name).Y+button:get(name).shadowY, 
		button:get(name).width, 
		button:get(name).height, 
		button:get(name).rx, 
		button:get(name).ry, 
		button:get(name).segments
	)
	love.graphics.setColor(button:get(name).color)
	love.graphics.rectangle(
		"fill", 
		button:get(name).X + button:get(name).incrX, 
		button:get(name).Y + button:get(name).incrY, 
		button:get(name).width, 
		button:get(name).height, 
		button:get(name).rx, 
		button:get(name).ry, 
		button:get(name).segments
	)

	love.graphics.setColor(255,255,255)
	if button:get(name).backgroundImage then
		love.graphics.draw(
			button:get(name).backgroundImage, 
			button:get(name).X + button:get(name).incrX + (2 * button:get(name).width - math.sqrt(2) * button:get(name).width)/4, 
			button:get(name).Y + button:get(name).incrY + (2 * button:get(name).height - math.sqrt(2) * button:get(name).height)/4, 
			0, 
			button:get(name).width/(math.sqrt(2)*button:get(name).backgroundImage:getWidth()), 
			button:get(name).height/(math.sqrt(2)*button:get(name).backgroundImage:getHeight())
		)
	end

	love.graphics.setColor(0,0,0)
	love.graphics.setFont(button:get(name).font)
	love.graphics.print(--shadow
		button:get(name).value, 
		button:get(name).X + (button:get(name).width - button:get(name).font:getWidth(button:get(name).value))*0.5 + 1 + button:get(name).incrX, 
		button:get(name).Y + (button:get(name).height - button:get(name).font:getHeight())/2 + 1 + button:get(name).incrY
	)
	--love.graphics.print(button:get(name).value, button:get(name).X + (button:get(name).width - button:get(name).font:getWidth(button:get(name).value))*0.5 - 1, button:get(name).Y + (button:get(name).height - button:get(name).font:getHeight())/2 - 1)
	
	if(self:hovered(name)) then
		love.graphics.setColor(0,0,0)
		button:get(name).onhover()
	else
		love.graphics.setColor(button:get(name).fontColor)
	end
	love.graphics.print(
		button:get(name).value, 
		button:get(name).X + (button:get(name).width - button:get(name).font:getWidth(button:get(name).value))*0.5 + button:get(name).incrX, 
		button:get(name).Y + (button:get(name).height - button:get(name).font:getHeight())/2 + button:get(name).incrY
	)
end

function button:exists(name)
	return button:get(name) ~= nil
end

function button:hovered(name)
	cursX, cursY = love.mouse.getPosition()
	if cursX > button:get(name).X + screen:get(button:get(name).screen).X
		and cursX < button:get(name).X + screen:get(button:get(name).screen).X + button:get(name).width
		and cursY > button:get(name).Y + screen:get(button:get(name).screen).Y
		and cursY < button:get(name).Y + screen:get(button:get(name).screen).Y + button:get(name).height 
		then
			return true
	end
	return false
end

function button:get(name)
	return self.b[name]
end