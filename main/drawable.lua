drawable = {
	
	button = function(x, y, width, height, value, color, font, fontColor)

		value = value or "default"
		color = color or {0,0,0}
		font = font or love.graphics.newFont("runFont.ttf", fontSize)
		fontColor = fontColor or {255, 255, 255}

		love.graphics.setColor(color)
		love.graphics.rectangle(
			"fill", 
			x, 
			y, 
			width, 
			height
		)
		love.graphics.setColor(color)
		love.graphics.setFont(font)
		love.graphics.print({fontColor, value}, closeButton.X + 3, closeButton.Y + 5)
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
	end,

	mainCircle = function( ... )
		-- body
	end


}