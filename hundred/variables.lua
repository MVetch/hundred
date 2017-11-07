x = love.graphics.getWidth()
y = love.graphics.getHeight()
fontSize = getPercent(x, 3.125)
BackgroundColor = {252, 15, 192}

---------------circle-----------------
initialColor = love.math.random(0, 255)

circleColor = {
	red = love.math.random(255),
	blue = love.math.random(255),
	green = love.math.random(255)
}

circleColorInit = circleColor

mainCircle = {
	color = circleColor,
	radius = getPercent(y, 25),
	X = getPercent(x, 25),
	Y = getPercent(y, 40),
	angle = 0
}
---------------circle-----------------

time = -3
buttonFont = love.graphics.newFont("joystix monospace.ttf", fontSize)
answerFont = love.graphics.newFont("runFont.ttf", getPercent(x, 1.953125))
expressionFont = love.graphics.newFont("runFont.ttf", getPercent(x, 2.34375))

amountOfTries = 0
usedNumbers = 0
resultString = ""
answer = ""
goal = 100
winAnswer = goal .. "! You won! Click here to try again."
almostAnswer = goal .. ", but not all numbers used."