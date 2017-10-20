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
		actColor = {123,237,203},
		color = {123,237,203},
		blockedColor = {153,153,153},
		fontColor = {255,0,0},
		X = mainCircle.X - mainCircle.radius,
		Y = mainCircle.Y + mainCircle.radius/2 + 50,
		value = "run"
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
			height = button.height,
			color = button.color
		},
		{
			value = "",
			X = x-Xincr,
			Y = initY + Yincr * 1,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} ,
			width = button.width,
			height = button.height,
			color = button.color,
			color = button.color
		},
		{
			value = "",
			X = x-Xincr,
			Y = initY + Yincr * 2,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} ,
			width = button.width,
			height = button.height,
			color = button.color
		},
		{
			value = "",
			X = x-Xincr,
			Y = initY + Yincr * 3,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} ,
			width = button.width,
			height = button.height,
			color = button.color
		},
		{
			value = "",
			X = x-Xincr,
			Y = initY + Yincr * 4,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0} ,
			width = button.width,
			height = button.height,
			color = button.color
		},
		{
			value = "",
			X = x-Xincr,
			Y = initY + Yincr * 5,
			clicked = false,
			textColor = BackgroundColor,
			textColorClicked = {255,0,0},
			width = button.width,
			height = button.height,
			color = button.color
		}
	}

	operationButtons = {
		{
			value = "+",
			X = results[1].X + posXincr,
			Y = results[1].Y,
			width = button.width,
			height = button.height,
			color = button.color
		},
		{
			value = "x",
			X = results[2].X + posXincr,
			Y = results[2].Y,
			width = button.width,
			height = button.height,
			color = button.color
		},
		{
			value = "(",
			X = results[3].X + posXincr,
			Y = results[3].Y,
			width = button.width,
			height = button.height,
			color = button.color
		},
		{
			value = "^",
			X = results[4].X + posXincr,
			Y = results[4].Y,
			width = button.width,
			height = button.height,
			color = button.color
		},
		{
			value = "!",
			X = results[5].X + posXincr,
			Y = results[5].Y,
			width = button.width,
			height = button.height,
			color = button.color
		},
		{
			value = "-",
			X = results[1].X + 1.2*posXincr + button.width,
			Y = results[1].Y,
			width = button.width,
			height = button.height,
			color = button.color
		},
		{
			value = "/",
			X = results[2].X + 1.2*posXincr + button.width,
			Y = results[2].Y,
			width = button.width,
			height = button.height,
			color = button.color
		},
		{
			value = ")",
			X = results[3].X + 1.2*posXincr + button.width,
			Y = results[3].Y,
			width = button.width,
			height = button.height,
			color = button.color
		},
		{
			value = "√",
			X = results[4].X + 1.2*posXincr + button.width,
			Y = results[4].Y,
			width = button.width,
			height = button.height,
			color = button.color
		},
		{
			value = "C",
			X = results[5].X + 1.2*posXincr + button.width,
			Y = results[5].Y,
			width = button.width,
			height = button.height,
			color = button.color
		}
	}

	equalButton = {
		value = "=",
		X = results[6].X + posXincr,
		Y = results[6].Y,
		width = button.width*2 + 0.2*posXincr,
		height = button.height,
		color = button.color
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
	textRad = radius - 60

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
		love.graphics.setFont(button.font)
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

function rotate()
	mainCircle.angle = mainCircle.angle + 1/math.pi
end

function game.show()

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
		runButton.color = runButton.blockedColor
	else 
		runButton.color = runButton.actColor
	end

	drawable.button(runButton)

	runButtonBlocked = tern(os.clock()-time<=1.0, true, false)

	if rotateFlag then
		rotate()
	else
		runButtonBlocked = false
	end
	--topLeft(os.clock()-time)
	topLeft(amountOfTries)
	
	for i=1, 6, 1 do --number buttons
		drawable.button(results[i])
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
			drawable.button(operationButtons[5*(i-1)+j])
		end
	end

	drawable.button(equalButton)
end