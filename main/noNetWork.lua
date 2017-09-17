noNetWork = {}

function noNetWork.show()
	love.graphics.setColor({0,0,0})--numbers
	love.graphics.setFont(button.font)
	str = "Network error"
	love.graphics.print(str, x/2 - str:len()*fontSize/2, getPercent(y, 30) + mainCircle.radius + 50)
	drawReturnButton()
end

function drawReturnButton()
	love.graphics.setColor(returnButton.color)--number buttons
	love.graphics.rectangle(
		"fill", 
		returnButton.X, 
		returnButton.Y, 
		returnButton.width, 
		returnButton.height,
		10,
		10,
		40
	)

	love.graphics.setColor(returnButton.textColor)--numbers
	love.graphics.setFont(button.font)
	love.graphics.print(returnButton.value, returnButton.X+30, returnButton.Y+15)
end