---------------essential-----------------
x = love.graphics.getWidth()
y = love.graphics.getHeight()
fontSize = getPercent(x, 3.125)
BackgroundColor = {218, 236, 99}
blockedColor = {153,153,153}
wheelSound = love.audio.newSource("sound/wheel.wav")
soundOnPic = love.graphics.newImage("img/soundOn.png")
soundOffPic = love.graphics.newImage("img/soundOff.png")
---------------/essential-----------------

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
	Y = getPercent(y, 35),
	angle = 0
}
---------------/circle-----------------

---------------fonts-----------------
buttonFont = love.graphics.newFont("fonts/joystix monospace.ttf", fontSize)
smallFont = love.graphics.newFont("fonts/joystix monospace.ttf", 20)
answerFont = love.graphics.newFont("fonts/runFont.ttf", getPercent(x, 1.953125))
expressionFont = love.graphics.newFont("fonts/runFont.ttf", getPercent(x, 2.34375))
---------------/fonts-----------------

---------------game-----------------
time = -3
amountOfTries = 0
usedNumbers = 0
resultString = ""
answer = ""
goal = 100
winAnswer = goal .. "! You won! Click here to try again."
almostAnswer = goal .. ", but not all numbers used."
---------------/game-----------------

operations = {
	{
		value = "+",
		precedence = 1,
		associativity = 0, --0 left, 1 right
		result = function(a, b)
			if b == nil then
				return false
			end
			return a+b
		end
	},
	{
		value = "x",
		precedence = 2,
		associativity = 0, --0 left, 1 right
		result = function(a, b)
			if b == nil then
				return false
			end
			return a*b
		end
	},
	{
		value = "√",
		precedence = 4,
		associativity = 0, --0 left, 1 right
		result = function(a)
			if a<0 then 
				return "Error in sqrt function: argument should be more than 0"
			else
				return math.sqrt(a)
			end
		end
	},
	{
		value = "("
	},
	{
		value = "!",
		precedence = 5,
		associativity = 0, --0 left, 1 right
		result = function(a)
			if a == 0 then
				return 1
			elseif a < 0 then
				return "Error in factorial function: argument should be more than -1"
			else
				ret = 1
				for i=1, a, 1 do
					ret = ret*i
				end
				return ret
			end
		end
	},
	{
		value = "-",
		precedence = 1,
		associativity = 0, --0 left, 1 right
		result = function(a, b)
			if b == nil then
				return false
			end
			return b-a
		end
	},
	{
		value = "/",
		precedence = 2,
		associativity = 0, --0 left, 1 right
		result = function(a, b)
			if b == nil then
				return false
			end
			if a == 0 then 
				return "Error in division function: dividing by 0"
			end
			return b/a
		end
	},
	{
		value = "^",
		precedence = 4,
		associativity = 0, --0 left, 1 right
		result = function(a, b)
			if b == nil then
				return false
			end
			tb=1
			for i=1, a, 1 do
				tb = b*tb
			end
			return tb
		end
	},
	{
		value = ")"
	}
}