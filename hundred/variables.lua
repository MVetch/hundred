version = 0.2
---------------essential-----------------
if love.math then
	love.math.setRandomSeed(os.time())
end

x = love.graphics.getWidth()
y = love.graphics.getHeight()
cursor = {
	x = 0,
	y = 0
}
fontSize = getPercent(x, 3.125)
BackgroundColor = {218, 236, 99}
blockedColor = {153,153,153}

	---------------sounds---------------
soundCircle = love.audio.newSource("sound/wheel.wav")
soundSpinner = love.audio.newSource("sound/spinner.wav")
soundSwaston = love.audio.newSource("sound/swaston.mp3")
	---------------/sounds---------------

	---------------pics---------------
soundOnPic = love.graphics.newImage("img/soundOn.png")
soundOffPic = love.graphics.newImage("img/soundOff.png")
spincoinPic = love.graphics.newImage("img/spincoin.png")
spincoinAnimate = love.graphics.newImage("img/spincoinAnimate.png")
settingsPic = love.graphics.newImage("img/settings.png")

skinCircle = love.graphics.newImage("img/circle.png") -- 1
skinSwaston = love.graphics.newImage("img/swaston.png") -- 2
skinSpinner = love.graphics.newImage("img/spinner.png") -- 3
skinAlien = love.graphics.newImage("img/alien.png") -- 4
skinHandWheel = love.graphics.newImage("img/handwheel.png") -- 5
skinHypno = love.graphics.newImage("img/hypno.png") -- 6
skinMandelbrot = love.graphics.newImage("img/mandelbrot.png") -- 7

	---------------/pics---------------

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
	X = getPercent(x, 30),
	Y = getPercent(y, 35),
	angle = 0
}
---------------/circle-----------------

---------------fonts-----------------
buttonFont = love.graphics.newFont("fonts/joystix monospace.ttf", fontSize)
smallFont = love.graphics.newFont("fonts/joystix monospace.ttf", fontSize/2)
answerFont = love.graphics.newFont("fonts/runFont.ttf", getPercent(x, 1.953125))
expressionFont = love.graphics.newFont("fonts/runFont.ttf", getPercent(x, 2.34375))
titleFont = love.graphics.newFont("fonts/joystix monospace.ttf", fontSize*0.75)
---------------/fonts-----------------

---------------game-----------------
time = -3
amountOfTries = 0
usedNumbers = 0
resultString = ""
answer = ""
goal = 100
winAnswer = goal .. "! You won!"
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
				return "Error in factorial function: argument shouldn't be less than 0"
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
			return b^a
		end
	},
	{
		value = ")"
	}
}