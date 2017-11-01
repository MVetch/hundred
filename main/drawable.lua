drawable = {
	
	button = function(button)

		local x = button.X or 0
		local y = button.Y or 0
		local width = button.width or 10 
		local height = button.height or 10
		local value = button.value or "default"
		local color = button.color or {0,0,0}
		local fontSize = button.fontSize or fontSize
		local font = button.font or buttonFont
		local fontColor = button.fontColor or BackgroundColor
		local rx = button.rx or 10
		local ry = button.ry or 10
		local segments = button.segments or 40

		love.graphics.setColor(color)
		love.graphics.rectangle(
			"fill", 
			x, 
			y, 
			width, 
			height, 
			rx, 
			ry, 
			segments
		)

		cursX, cursY = love.mouse.getPosition()
		if cursX > x
			and cursX < x + width
			and cursY > y
			and cursY < y + height 
			then
				love.graphics.setColor(0,0,0)
		else
			love.graphics.setColor(fontColor)
		end
		
		love.graphics.setFont(font)
		love.graphics.print(value, x + (width - string.width(value, fontSize))*0.5, y + (height - fontSize*1.25)/2)
	end,

	triangle = function(leftSideX, leftSideY, centerX, centerY, rightSideX, rightSideY)
		love.graphics.setColor(0,0,0)
		love.graphics.polygon(
			"fill", 
			leftSideX, 
			leftSideY,
			centerX, 
			centerY,
			rightSideX, 
			rightSideY
		)
	end
}