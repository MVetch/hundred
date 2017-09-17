wait = {draw = false}

function wait.show()
	drawReturnButton()
	drawMainCircle(getPercent(x, 50), getPercent(y, 30), mainCircle.color)
	rotate()
	str = "Searching for the enemy..."
	love.graphics.print(str, x/2 - str:len()*fontSize/2, getPercent(y, 30) + mainCircle.radius + 50)
end