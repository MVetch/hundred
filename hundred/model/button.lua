button = {
	b={},
	width = getPercent(x, 7.8125),
	height = getPercent(x, 3.90625),
	color = {123,237,203},
	font = love.graphics.newFont("fonts/joystix monospace.ttf", fontSize),
	font1 = love.graphics.newFont("fonts/joystix monospace.ttf", fontSize + 2),
	fontColor = {255,0,0}
}

function button:click(name)
	self.b[name].incrX = self.b[name].incrX + self.b[name].shadowX - 1
	self.b[name].incrY = self.b[name].incrY + self.b[name].shadowY - 1
end

function button:release(name)
	self.b[name].incrX = self.b[name].incrX - self.b[name].shadowX + 1
	self.b[name].incrY = self.b[name].incrY - self.b[name].shadowY + 1
	self.b[name].onclick()
end

function button:add(name, newbutton, screen)
	self.b[name] = {}
	self.b[name].X = newbutton.X or 0
	self.b[name].Y = newbutton.Y or 0
	self.b[name].width = newbutton.width or self.width
	self.b[name].height = newbutton.height or self.height
	self.b[name].value = newbutton.value or "Push!"
	self.b[name].backgroundImage = newbutton.backgroundImage
	self.b[name].color = newbutton.color or self.color
	self.b[name].fontSize = newbutton.fontSize or fontSize
	self.b[name].font = newbutton.font or buttonFont
	self.b[name].fontColor = newbutton.fontColor or BackgroundColor
	self.b[name].rx = newbutton.rx or 10
	self.b[name].ry = newbutton.ry or 10
	self.b[name].segments = newbutton.segments or 40
	self.b[name].shadowX = newbutton.shadowX or 3
	self.b[name].shadowY = newbutton.shadowY or 3
	self.b[name].incrX = 0
	self.b[name].incrY = 0
	self.b[name].onclick = newbutton.onclick or function() end
	self.b[name].onhover = newbutton.onhover or function() end
	screen = screen or screens.background
	table.insert(screen.buttons, name)
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
		self.b[name].X+self.b[name].shadowX, 
		self.b[name].Y+self.b[name].shadowY, 
		self.b[name].width, 
		self.b[name].height, 
		self.b[name].rx, 
		self.b[name].ry, 
		self.b[name].segments
	)
	love.graphics.setColor(self.b[name].color)
	love.graphics.rectangle(
		"fill", 
		self.b[name].X + self.b[name].incrX, 
		self.b[name].Y + self.b[name].incrY, 
		self.b[name].width, 
		self.b[name].height, 
		self.b[name].rx, 
		self.b[name].ry, 
		self.b[name].segments
	)

	love.graphics.setColor(255,255,255)
	if self.b[name].backgroundImage then
		love.graphics.draw(
			self.b[name].backgroundImage, 
			self.b[name].X + self.b[name].incrX + (2 * self.b[name].width - math.sqrt(2) * self.b[name].width)/4, 
			self.b[name].Y + self.b[name].incrY + (2 * self.b[name].height - math.sqrt(2) * self.b[name].height)/4, 
			0, 
			self.b[name].width/(math.sqrt(2)*self.b[name].backgroundImage:getWidth()), 
			self.b[name].height/(math.sqrt(2)*self.b[name].backgroundImage:getHeight())
		)
	end

	love.graphics.setColor(0,0,0)
	love.graphics.setFont(self.b[name].font)
	love.graphics.print(--shadow
		self.b[name].value, 
		self.b[name].X + (self.b[name].width - self.b[name].font:getWidth(self.b[name].value))*0.5 + 1 + self.b[name].incrX, 
		self.b[name].Y + (self.b[name].height - self.b[name].font:getHeight())/2 + 1 + self.b[name].incrY
	)
	--love.graphics.print(self.b[name].value, self.b[name].X + (self.b[name].width - self.b[name].font:getWidth(self.b[name].value))*0.5 - 1, self.b[name].Y + (self.b[name].height - self.b[name].font:getHeight())/2 - 1)
	
	if(self:hovered(name)) then
		love.graphics.setColor(0,0,0)
		self.b[name].onhover()
	else
		love.graphics.setColor(self.b[name].fontColor)
	end
	love.graphics.print(
		self.b[name].value, 
		self.b[name].X + (self.b[name].width - self.b[name].font:getWidth(self.b[name].value))*0.5 + self.b[name].incrX, 
		self.b[name].Y + (self.b[name].height - self.b[name].font:getHeight())/2 + self.b[name].incrY
	)
end

function button:exists(name)
	return self.b[name] ~= nil
end

function button:hovered(name)
	cursX, cursY = love.mouse.getPosition()
	if cursX > self.b[name].X
		and cursX < self.b[name].X + self.b[name].width
		and cursY > self.b[name].Y
		and cursY < self.b[name].Y + self.b[name].height 
		then
			return true
	end
	return false
end

function button:get(name)
	return self.b[name]
end