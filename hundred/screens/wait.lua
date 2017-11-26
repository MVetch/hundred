function screen.s.wait.show()
	drawable.button(returnButton)
	drawMainCircle(getPercent(x, 50), getPercent(y, 30), mainCircle.color)
	rotate()
	str = "Searching for the enemy..."
	love.graphics.print(str, (x - string.width(str, fontSize))*0.5, getPercent(y, 30) + mainCircle.radius + 50)
end