game = {draw = false}
function love.load()
	
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

	runButton = {
		width = mainCircle.radius * 2,
		height = 50,
		color = {123,237,203},
		blockedColor = {153,153,153},
		font = love.graphics.newFont("runFont.ttf", 40),
		fontColor = {255,0,0},
		X = mainCircle.X - mainCircle.radius,
		Y = mainCircle.Y + mainCircle.radius/2 + 50
	}
	--circle = love.graphics.newImage("")

	posXincr = 160

	time = -3
	initY = 75
	Yincr = 70
	Xincr = 2*button.width + 1.2*posXincr + mainCircle.X - mainCircle.radius
	results = {
		{
			value = "",
			X = x-Xincr,
			Y = initY + Yincr * 0,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} ,
			width = button.width,
			height = button.height
		},
		{
			value = "",
			X = x-Xincr,
			Y = initY + Yincr * 1,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} ,
			width = button.width,
			height = button.height
		},
		{
			value = "",
			X = x-Xincr,
			Y = initY + Yincr * 2,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} ,
			width = button.width,
			height = button.height
		},
		{
			value = "",
			X = x-Xincr,
			Y = initY + Yincr * 3,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} ,
			width = button.width,
			height = button.height
		},
		{
			value = "",
			X = x-Xincr,
			Y = initY + Yincr * 4,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} ,
			width = button.width,
			height = button.height
		},
		{
			value = "",
			X = x-Xincr,
			Y = initY + Yincr * 5,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} ,
			width = button.width,
			height = button.height
		}
	}

	operationButtons = {
		{
			value = "+",
			X = results[1].X + posXincr,
			Y = results[1].Y,
			width = button.width,
			height = button.height
		},
		{
			value = "x",
			X = results[2].X + posXincr,
			Y = results[2].Y,
			width = button.width,
			height = button.height
		},
		{
			value = "(",
			X = results[3].X + posXincr,
			Y = results[3].Y,
			width = button.width,
			height = button.height
		},
		{
			value = "^",
			X = results[4].X + posXincr,
			Y = results[4].Y,
			width = button.width,
			height = button.height
		},
		{
			value = "!",
			X = results[5].X + posXincr,
			Y = results[5].Y,
			width = button.width,
			height = button.height
		},
		{
			value = "-",
			X = results[1].X + 1.2*posXincr + button.width,
			Y = results[1].Y,
			width = button.width,
			height = button.height
		},
		{
			value = "/",
			X = results[2].X + 1.2*posXincr + button.width,
			Y = results[2].Y,
			width = button.width,
			height = button.height
		},
		{
			value = ")",
			X = results[3].X + 1.2*posXincr + button.width,
			Y = results[3].Y,
			width = button.width,
			height = button.height
		},
		{
			value = "√",
			X = results[4].X + 1.2*posXincr + button.width,
			Y = results[4].Y,
			width = button.width,
			height = button.height
		},
		{
			value = "C",
			X = results[5].X + 1.2*posXincr + button.width,
			Y = results[5].Y,
			width = button.width,
			height = button.height
		}
	}

	equalButton = {
		value = "=",
		X = results[6].X + posXincr,
		Y = results[6].Y,
		width = button.width*2 + 0.2*posXincr,
		height = button.height
	}

	answerField = {
		X = mainCircle.X - mainCircle.radius,
		Y = mainCircle.Y + mainCircle.radius + runButton.height + 120,
		width = x - 2*(mainCircle.X - mainCircle.radius),
		height = 50
	}

	amountOfTries = 0
	resultString = ""
	answer = ""
end

function setDefaultValues()
	amountOfTries = 0
	resultString = ""
	answer = ""
	for i = 1, 6, 1 do
		results[i].value = ""
		results[i].clicked = false
	end
	udp:send('default')
end

function drawMainCircle(X, Y, initCol)
	radius = mainCircle.radius
	love.graphics.setColor(255,255,255)
	red = initCol.red
	blue = initCol.blue
	green = initCol.green
	angle = mainCircle.angle
	deg = degToRad(-36)
	degIncr = degToRad(36)
	textDeg = degToRad(18)
	textDegIncr = degToRad(36)
	textRad = radius - 50

	for i=0,10,1 do

		while red > 255 do--so colors won't overflow 255
			red=red-255
		end
		while blue > 255 do
			blue=blue-255
		end
		while green > 255 do
			green=green-255
		end

		love.graphics.setColor(red, green, blue)
		love.graphics.polygon(
			"fill", 
			X, 
			Y, 
			X+(radius*math.sin(deg)*math.cos(angle) - radius*math.cos(deg)*math.sin(angle)), 
			Y+(radius*math.cos(deg)*math.cos(angle) + radius*math.sin(deg)*math.sin(angle)), 
			X+(radius*math.sin(deg+degIncr)*math.cos(angle) - radius*math.cos(deg+degIncr)*math.sin(angle)), 
			Y+(radius*math.cos(deg+degIncr)*math.cos(angle) + radius*math.sin(deg+degIncr)*math.sin(angle))
		)
		love.graphics.setFont(runButton.font)
		love.graphics.print(
			{
				{0,0,0},
				i-1
			},
			X+(textRad*math.sin(deg+degIncr/2-0.75/(2*math.pi))*math.cos(angle) - textRad*math.cos(deg+degIncr/2-0.75/(2*math.pi))*math.sin(angle)), 
			Y+(textRad*math.cos(deg+degIncr/2-0.75/(2*math.pi))*math.cos(angle) + textRad*math.sin(deg+degIncr/2-0.75/(2*math.pi))*math.sin(angle)),
			textDeg + angle
		)
		deg = deg + degIncr
		textDeg = textDeg - textDegIncr

		red = red * 3
		blue = blue * 2
		green = green * 5
	end
end

function drawRunButton(x, y, width, height, value)

	love.graphics.rectangle("fill", x, y, width, height)

	love.graphics.setColor(runButton.fontColor)
	love.graphics.setFont(runButton.font)
	love.graphics.print({runButton.fontColor, value}, x + width/2 - 50, y + height/2 - 15)
end

function getPercent(value, percents)
	return value * percents / 100
end

function rotate()
	mainCircle.angle = mainCircle.angle + 1/math.pi
end

function degToRad(deg)
	return deg*math.pi/180
end

function drawEqButton()
	love.graphics.setColor(runButton.color)--number buttons
	love.graphics.rectangle(
		"fill", 
		equalButton.X, 
		equalButton.Y, 
		equalButton.width, 
		button.height,
		10,
		10,
		40
	)
	love.graphics.setColor(BackgroundColor)--numbers
	love.graphics.setFont(runButton.font)
	love.graphics.print(equalButton.value, equalButton.X+equalButton.width/2 -20, equalButton.Y+15)
end

function game.show()
	drawable.button(
		x-closeButton.width,
		0,
		closeButton.width,
		closeButton.height,
		closeButton.value
	)

	drawable.triangle(
		mainCircle.X - mainCircle.radius/8, 
		mainCircle.Y + mainCircle.radius/2 + 30,
		mainCircle.X, 
		mainCircle.Y + mainCircle.radius/2 + 10,
		mainCircle.X + mainCircle.radius/8, 
		mainCircle.Y + mainCircle.radius/2 + 30
	)

	drawMainCircle(
		mainCircle.X, 
		mainCircle.Y - mainCircle.radius/2, 
		mainCircle.color
	)

	if runButtonBlocked then
		runButton.actColor  = runButton.blockedColor
	else 
		runButton.actColor = runButton.color
	end

	drawable.button(
		runButton.X, 
		runButton.Y, 
		runButton.width, 
		runButton.height, 
		"run",
		runButton.fontColor
	)

	if rotateFlag then
		rotate()
	end
	--love.graphics.print(os.clock()-time, 0,0)

	
	for i=1, 6, 1 do --number buttons
		drawable.button(
			results[i].X, 
			results[i].Y,
			button.width, 
			button.height,
			results[i].value,
			results[i].textColor
		)
	end


	love.graphics.setColor(234, 215, 150)--calc field
	love.graphics.rectangle(
		"fill",
		mainCircle.X - mainCircle.radius,
		mainCircle.Y + mainCircle.radius + runButton.height,
		x - 2*(mainCircle.X - mainCircle.radius), 
		100
	)

	love.graphics.setColor(0, 0, 150)--answer field
	love.graphics.rectangle(
		"fill",
		answerField.X,
		answerField.Y,
		answerField.width,
		answerField.height
	)
	if answer == "100! You won! Click here to try again." then
		love.graphics.setColor(0,255,0)--answer itself
	else
		love.graphics.setColor(255,0,0)
	end
	love.graphics.setFont(love.graphics.newFont("runFont.ttf", 25))
	love.graphics.print( --answer itself
		answer,
		mainCircle.X - mainCircle.radius + 5,
		mainCircle.Y + mainCircle.radius + runButton.height + 135
	)

	love.graphics.setColor(50,50,50)--calc string
	love.graphics.setFont(love.graphics.newFont("runFont.ttf", 30))
	love.graphics.print(
		resultString,
		mainCircle.X - mainCircle.radius,
		mainCircle.Y + mainCircle.radius + runButton.height + 40
	)

	for i=1,2,1 do
		for j=1,5,1 do
			drawButton(
				operationButtons[5*(i-1)+j].X,
				operationButtons[5*(i-1)+j].Y,
				operationButtons[5*(i-1)+j].value,
				BackgroundColor
			)
		end
	end

	drawEqButton()

	runButtonBlocked = tern(os.clock()-time<=1.0, true, false)
end

function tern ( cond , T , F )
    if cond then return T else return F end
end
