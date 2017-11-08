drawable = {
	
	button = function(button_temp)

		local x = button_temp.X or 0
		local y = button_temp.Y or 0
		local width = button_temp.width or 10 
		local height = button_temp.height or 10
		local value = button_temp.value or "default"
		local color = button_temp.color or {0,0,0}
		local fontSize = button_temp.fontSize or fontSize
		local font = button_temp.font or buttonFont
		local fontColor = button_temp.fontColor or BackgroundColor
		local rx = button_temp.rx or 10
		local ry = button_temp.ry or 10
		local segments = button_temp.segments or 40


		love.graphics.setColor(0,0,0)
		love.graphics.rectangle(
			"fill", 
			x, 
			y, 
			width+3, 
			height+3, 
			rx, 
			ry, 
			segments
		)
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