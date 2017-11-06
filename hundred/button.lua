button = {
	b={}
}

function button:click(name)
	self.b[name].onclick()
end

function button:add(name, newbutton)
	self.b[name].X = newbutton.X or 0
	self.b[name].Y = newbutton.Y or 0
	self.b[name].width = newbutton.width or 100
	self.b[name].height = newbutton.height or 50
	self.b[name].value = newbutton.value or "Push!"
	self.b[name].color = newbutton.color or {0,0,0}
	self.b[name].fontSize = newbutton.fontSize or fontSize
	self.b[name].font = newbutton.font or buttonFont
	self.b[name].fontColor = newbutton.fontColor or BackgroundColor
	self.b[name].rx = newbutton.rx or 10
	self.b[name].ry = newbutton.ry or 10
	self.b[name].segments = newbutton.segments or 40
	self.b[name].shadowX = newbutton.shadowX or 3
	self.b[name].shadowY = newbutton.shadowY or 3
	self.b[name].onclick = newbutton.onclick or function() end
	self.b[name].onhover = newbutton.onhover or function() end
end

function button:delete(name)
	table.remove(self.b, name)
end

function button:draw(name)
	if not self.exists(name) then
		error("button " .. name .. " doesn't exist.")
	end
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle(
		"fill", 
		self.b[name].X, 
		self.b[name].Y, 
		self.b[name].width+self.b[name].shadowX, 
		self.b[name].height+self.b[name].shadowY, 
		self.b[name].rx, 
		self.b[name].ry, 
		self.b[name].segments
	)
	love.graphics.setColor(self.b[name].color)
	love.graphics.rectangle(
		"fill", 
		self.b[name].X, 
		self.b[name].Y, 
		self.b[name].width, 
		self.b[name].height, 
		self.b[name].rx, 
		self.b[name].ry, 
		self.b[name].segments
	)

	cursX, cursY = love.mouse.getPosition()
	if cursX > self.b[name].X
		and cursX < self.b[name].X + self.b[name].width
		and cursY > self.b[name].Y
		and cursY < self.b[name].Y + self.b[name].height 
		then
			love.graphics.setColor(0,0,0)
			self.b[name].onhover()
	else
		love.graphics.setColor(fontColor)
	end

	love.graphics.setFont(self.b[name].font)
	love.graphics.print(self.b[name].value, self.b[name].x + (self.b[name].width - string.width(self.b[name].value, fontSize))*0.5, y + (self.b[name].height - fontSize*1.25)/2)
end

function button:exists(name)
	return self.b[name] ~= nil
end