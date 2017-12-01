drawable = {

	ring = function(x, y, radius, width)
		width = width or 0
		for i = 0, width - 1, 1 do
			love.graphics.circle("line", x, y, radius - i)
		end
	end,

	arc = function(x, y, radius, angle1, angle2, width)
		width = width or 0
		for i = 0, width - 1, 1 do
			love.graphics.arc("line", "open", x, y, radius - i, angle1, angle2)
		end
	end,

	border = function(x, y, w, h, b)
		width = width or 0
		love.graphics.rectangle("fill", x, y, b.left, h)
		love.graphics.rectangle("fill", x, y, w, b.top)
		love.graphics.rectangle("fill", w-b.right, y, b.right, h)
		love.graphics.rectangle("fill", x, h-b.bottom, w, b.bottom)
	end,

	circle = function(x, y, radius)
		love.graphics.circle("fill", x, y, radius)
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