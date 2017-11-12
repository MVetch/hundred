function love.load()
	button:add("run", {
		width = mainCircle.radius * 2,
		actColor = {123,237,203},
		color = {123,237,203},
		blockedColor = {153,153,153},
		fontColor = {255,0,0},
		X = mainCircle.X - mainCircle.radius,
		Y = mainCircle.Y + mainCircle.radius + getPercent(x, 3.90625),
		value = "spin",
		onclick = function()
			if not runButtonBlocked then
				rotateFlag = not rotateFlag
				if not rotateFlag then
					if amountOfTries < 6 then
						result = 0
						tangle = mainCircle.angle
						while tangle > degToRad(36) do
							tangle = tangle - degToRad(36)
							result = result + 1
						end
						button:get("results" .. amountOfTries+1).value = result
						amountOfTries = amountOfTries + 1
						if onlinePlay then
							udp:send(string.format("%s %d %d %d", 'setValue', roomId, amountOfTries, result))
						end
						if amountOfTries == 6 then
							timer:start()
						end
					end
				end
				time = os.clock()
			end
		end
	}, screens.game)

	posXincr = button.width * 1.6
	initY = mainCircle.Y - mainCircle.radius
	Yincr = button.height * 1.4
	Xincr = 2 * button.width + 1.2 * posXincr + mainCircle.X - mainCircle.radius

	for i=1,6 do
		button:add("results" .. i, {
			value = "",
			X = x-Xincr,
			Y = initY + Yincr * (i - 1),
			clicked = false,
			onclick = function()
				if not button:get("results" .. i).clicked and button:get("results" .. i).value ~= "" then
					resultString = resultString .. button:get("results" .. i).value
					button:get("results" .. i).clicked = true
					button:get("results" .. i).value = ""
					usedNumbers = usedNumbers + 1
				end
			end
		}, screens.game)
	end

	for i=1,9 do
		if i < 6 then
			incr = posXincr
		else
			incr = 1.2*posXincr + button.width
		end
		button:add("operations" .. i, {
			X = button.b["results" .. ((i-1) % 5 + 1)].X + incr,
			Y = button.b["results" .. ((i-1) % 5 + 1)].Y,
			value = operations[i].value,
			onclick = function()
				resultString = resultString .. button:get("operations" .. i).value
			end
		}, screens.game)
	end

	button:add("operations" .. 10, {
		value = "C",
		X = button.b["results" .. 5].X + 1.2*posXincr + button.width,
		Y = button.b["results" .. 5].Y,
		onclick = function()
			if isNumber(string.sub(resultString,-1)) then
				for j=1,6,1 do
					if button.b["results" .. j].value == "" then
						button.b["results" .. j].value = string.sub(resultString,-1)
						button.b["results" .. j].clicked = false
						usedNumbers = usedNumbers - 1
						break
					end
				end
			end
			local byteoffset = utf8.offset(resultString, -1)
	        if byteoffset then
	            resultString = string.sub(resultString, 1, byteoffset - 1)
	        end
		end
	}, screens.game)

	button:add("equal", {
		value = "=",
		X = button.b["results" .. 6].X + posXincr,
		Y = button.b["results" .. 6].Y,
		width = button.width*2 + 0.2*posXincr,
		onclick = function()
			getAnswer(resultString)
		end
	}, screens.game)

	answerField = {
		X = mainCircle.X - mainCircle.radius,
		Y = button:get("run").Y + button:get("run").height + getPercent(x, 10.375),
		width = x - 2*(mainCircle.X - mainCircle.radius),
		height = button.height
	}
	-- answer2 = ""
	-- for k,b in pairs(game.buttons) do
	-- 	answer2 = answer2 .. "\n" .. button:get(b).X
	-- end

	button:add("skin", {
		X = x-4*button.width/2,
		width = button.width/2,
		value = "",
		color = {255, 0, 0},
		backgroundImage = skinTable[settings.skin].nextSkin,
		onclick = function()
			if skinTable[settings.skin].sound:isPlaying() then
				skinTable[settings.skin].sound:stop()
			end
			settings.skin = settings.skin + 1
			if settings.skin > table.getn(skinTable) then
				settings.skin = 1
			end
			button:get("skin").backgroundImage = skinTable[settings.skin].nextSkin
		end
	}, screens.game)
end

function setDefaultValues()
	amountOfTries = 0
	usedNumbers = 0
	resultString = ""
	answer = ""
	for i = 1, 6, 1 do
		button:get("results" .. i).value = ""
		button:get("results" .. i).clicked = false
	end
	if onlinePlay then
		udp:send('default')
	end
	timer:reset()
end

function rotateX(x, y, angle)
	return x*math.cos(angle) - y*math.sin(angle)
end
function rotateY(x, y, angle)
	return x*math.sin(angle) + y*math.cos(angle)
end

skinTable[1].func = function (X, Y, initCol)--circle
	radius = mainCircle.radius
	love.graphics.setColor(255,255,255)
	red = initCol.red
	blue = initCol.blue
	green = initCol.green
	angle = mainCircle.angle
	deg = 0
	degIncr = degToRad(36)

	for i=0,9,1 do

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
		-- love.graphics.setColor(0, 0, 0, 100)
		-- love.graphics.polygon(
		-- 	"fill", 
		-- 	X, 
		-- 	Y, 
		-- 	X+(radius*math.sin(deg)*math.cos(angle) - radius*math.cos(deg)*math.sin(angle)), 
		-- 	Y+(radius*math.cos(deg)*math.cos(angle) + radius*math.sin(deg)*math.sin(angle)), 
		-- 	X+(radius*math.cos(degIncr/3)^2*math.sin(deg+degIncr/3)*math.cos(angle) - radius*math.cos(deg+degIncr/3)*math.sin(angle)), 
		-- 	Y+(radius*math.cos(degIncr/3)^2*math.cos(deg+degIncr/3)*math.cos(angle) + radius*math.sin(deg+degIncr/3)*math.sin(angle))
		-- )
		deg = deg + degIncr

		red = red * 3
		blue = blue * 2
		green = green * 5
	end
	-- drawable.ring(X, Y, radius, 10)
	-- drawable.ring(X, Y, radius/2, 5)
	-- love.graphics.setColor(0,0,255)
	-- radius = radius - 5
	-- deg = deg + degIncr/2
	-- for i=0,9,1 do
	-- 	drawable.circle(
	-- 		X+(radius*math.sin(deg)*math.cos(angle) - radius*math.cos(deg)*math.sin(angle)), 
	-- 		Y+(radius*math.cos(deg)*math.cos(angle) + radius*math.sin(deg)*math.sin(angle)),
	-- 		5
	-- 	)
	-- 	-- drawable.circle(
	-- 	-- 	X+(radius/2*math.sin(deg)*math.cos(angle) - radius/2*math.cos(deg)*math.sin(angle)), 
	-- 	-- 	Y+(radius/2*math.cos(deg)*math.cos(angle) + radius/2*math.sin(deg)*math.sin(angle)),
	-- 	-- 	5
	-- 	-- )
	-- 	deg = deg + degIncr
	-- end
end

skinTable[2].func = function(X, Y) --swaston
	radius = mainCircle.radius
	angle = mainCircle.angle
	width = getPercent(x, 1.25)

	love.graphics.setColor(200, 0, 0)
	drawable.circle(X, Y, radius)

	radius = radius - buttonFont:getHeight()*1.5
	love.graphics.setColor(255, 255, 255)
	drawable.circle(X, Y, radius)
	radius = (radius - width)/1.5

	love.graphics.setColor(0, 0, 0)
	love.graphics.polygon(
		"fill", 
		X+rotateX((-width),(radius), angle), 
		Y+rotateY((-width),(radius), angle), 
		X+rotateX((-width), (-radius), angle), 
		Y+rotateY((-width), (-radius), angle), 
		X+rotateX((width), (-radius), angle), 
		Y+rotateY((width), (-radius), angle), 
		X+rotateX((width), (radius), angle), 
		Y+rotateY((width), (radius), angle)
	)
	love.graphics.polygon(
		"fill", 
		X+rotateX((-radius),(-width), angle), 
		Y+rotateY((-radius),(-width), angle), 
		X+rotateX((radius), (-width), angle), 
		Y+rotateY((radius), (-width), angle), 
		X+rotateX((radius), (width), angle), 
		Y+rotateY((radius), (width), angle), 
		X+rotateX((-radius), (width), angle), 
		Y+rotateY((-radius), (width), angle)
	)
	love.graphics.polygon(
		"fill", 
		X+rotateX((-width), (-radius-width), angle), 
		Y+rotateY((-width), (-radius-width), angle), 
		X+rotateX((width+radius), (-radius-width), angle), 
		Y+rotateY((width+radius), (-radius-width), angle), 
		X+rotateX((width+radius), (-radius+width), angle), 
		Y+rotateY((width+radius), (-radius+width), angle), 
		X+rotateX((-width), (-radius+width), angle), 
		Y+rotateY((-width), (-radius+width), angle)
	)
	love.graphics.polygon(
		"fill", 
		X+rotateX((-width-radius), (radius+width), angle), 
		Y+rotateY((-width-radius), (radius+width), angle), 
		X+rotateX((width), (radius+width), angle), 
		Y+rotateY((width), (radius+width), angle), 
		X+rotateX((width), (radius-width), angle), 
		Y+rotateY((width), (radius-width), angle), 
		X+rotateX((-width-radius), (radius-width), angle), 
		Y+rotateY((-width-radius), (radius-width), angle)
	)

	love.graphics.polygon(
		"fill", 
		X+rotateX((-width-radius),(-width-radius), angle), 
		Y+rotateY((-width-radius),(-width-radius), angle), 
		X+rotateX((width-radius),(-width-radius), angle), 
		Y+rotateY((width-radius),(-width-radius), angle), 
		X+rotateX((width-radius),(width), angle), 
		Y+rotateY((width-radius),(width), angle), 
		X+rotateX((-width-radius),(width), angle), 
		Y+rotateY((-width-radius),(width), angle)
	)
	love.graphics.polygon(
		"fill", 
		X+rotateX((-width+radius),(-width), angle), 
		Y+rotateY((-width+radius),(-width), angle), 
		X+rotateX((width+radius),(-width), angle), 
		Y+rotateY((width+radius),(-width), angle),
		X+rotateX((width+radius),(width+radius), angle), 
		Y+rotateY((width+radius),(width+radius), angle), 
		X+rotateX((-width+radius),(width+radius), angle), 
		Y+rotateY((-width+radius),(width+radius), angle)
	)
end
skinTable[3].func = function(X, Y, initCol) --spinner
	radius = mainCircle.radius
	angle = mainCircle.angle
	deg = degToRad(17.25)
	degIncr = degToRad(36)
	smRadius = buttonFont:getHeight()/2 + 10
	width = 5
	textRad = radius - getPercent(x, 4.6875) + buttonFont:getHeight()/2

	red = initCol.red
	blue = initCol.blue
	green = initCol.green
	for i=0,9,1 do
		drawable.arc(
			X+rotateX(textRad*math.sin(deg-degIncr/2), -textRad*math.cos(deg-degIncr/2), angle),
			Y+rotateY(textRad*math.sin(deg-degIncr/2), -textRad*math.cos(deg-degIncr/2), angle),
			smRadius,
			degToRad(30)+deg+angle,
			degToRad(120)+deg+angle,
			width
		)
		deg = deg+degIncr
	end
	for i=0,9,1 do

		while red > 255 do--so colors won't overflow 255
			red=red-255
		end
		while blue > 255 do
			blue=blue-255
		end
		while green > 255 do
			green=green-255
		end

		love.graphics.setColor(red,green,blue)
		drawable.circle(
			X+rotateX(textRad*math.sin(deg), -textRad*math.cos(deg), angle),
			Y+rotateY(textRad*math.sin(deg), -textRad*math.cos(deg), angle),
			smRadius
		)

		love.graphics.polygon(
			"fill",
			X,
			Y,
			X+rotateX(textRad*math.sin(deg-degIncr/4), -textRad*math.cos(deg-degIncr/4), angle),
			Y+rotateY(textRad*math.sin(deg-degIncr/4), -textRad*math.cos(deg-degIncr/4), angle),
			X+rotateX(textRad*math.sin(deg+degIncr/4), -textRad*math.cos(deg+degIncr/4), angle),
			Y+rotateY(textRad*math.sin(deg+degIncr/4), -textRad*math.cos(deg+degIncr/4), angle)
		)

		love.graphics.setColor(0,0,0)
		drawable.ring(
			X+rotateX(textRad*math.sin(deg), -textRad*math.cos(deg), angle),
			Y+rotateY(textRad*math.sin(deg), -textRad*math.cos(deg), angle),
			smRadius,
			width
		)
		deg = deg+degIncr

		red = red * 3
		blue = blue * 2
		green = green * 5
	end
	for i=0,radius/3/width,1 do
		love.graphics.setColor(i*width+100,i*width+100,i*width+100)
		drawable.circle(
			X,
			Y,
			radius/3-i*width
		)
	end
end
skinTable[4].func = function(X, Y, initCol) --alien
	radius = mainCircle.radius
	angle = mainCircle.angle
	love.graphics.setColor(255,255,255)
	--love.graphics.draw(skinAlienBack, X, Y, 0, 2*radius/skinAlienBack:getWidth(), 2*radius/skinAlienBack:getHeight(), skinAlienBack:getWidth()/2, skinAlienBack:getHeight()/2)
	love.graphics.draw(skinAlien, X, Y, angle, 2*radius/skinAlien:getWidth(), 2*radius/skinAlien:getHeight(), skinAlien:getWidth()/2, skinAlien:getHeight()/2)
	drawable.circle(
		X,
		Y,
		3
	)
end
skinTable[5].func = function(X, Y, initCol) --handwheel
	radius = mainCircle.radius
	angle = mainCircle.angle
	love.graphics.setColor(255,255,255)
	--love.graphics.draw(skinAlienBack, X, Y, 0, 2*radius/skinAlienBack:getWidth(), 2*radius/skinAlienBack:getHeight(), skinAlienBack:getWidth()/2, skinAlienBack:getHeight()/2)
	love.graphics.draw(skinHandWheel, X, Y, angle + 17.25, 2*radius/skinHandWheel:getWidth(), 2*radius/skinHandWheel:getHeight(), skinHandWheel:getWidth()/2, skinHandWheel:getHeight()/2)
	drawable.circle(
		X,
		Y,
		3
	)
end
skinTable[6].func = function(X, Y, initCol) --hypno
	radius = mainCircle.radius
	angle = mainCircle.angle
	love.graphics.setColor(255,255,255)
	love.graphics.draw(skinHipno, X, Y, angle + 17.25, 2*radius/skinHipno:getWidth(), 2*radius/skinHipno:getHeight(), skinHipno:getWidth()/2, skinHipno:getHeight()/2)
	love.graphics.setColor(0,0,0)
	--drawable.ring(X, Y, radius - buttonFont:getHeight()*0.3, buttonFont:getHeight())
	-- radius = radius - buttonFont:getHeight()*0.3
	-- drawable.circle(X, Y, radius)
	-- radius = radius - buttonFont:getHeight()*0.8
	-- love.graphics.setColor(255,255,255)
	-- drawable.circle(X, Y, radius)
	-- radius = radius - buttonFont:getHeight()*0.5
	--love.graphics.draw(skinAlienBack, X, Y, 0, 2*radius/skinAlienBack:getWidth(), 2*radius/skinAlienBack:getHeight(), skinAlienBack:getWidth()/2, skinAlienBack:getHeight()/2)
	drawable.circle(
		X,
		Y,
		3
	)
end
skinTable[7].func = function(X, Y, initCol) --mandelbrot
	radius = mainCircle.radius
	angle = mainCircle.angle
	love.graphics.setColor(255,255,255)
	--love.graphics.draw(skinAlienBack, X, Y, 0, 2*radius/skinAlienBack:getWidth(), 2*radius/skinAlienBack:getHeight(), skinAlienBack:getWidth()/2, skinAlienBack:getHeight()/2)
	love.graphics.draw(skinMandelbrot, X, Y, angle, 2*radius/skinMandelbrot:getWidth(), 2*radius/skinMandelbrot:getHeight(), skinMandelbrot:getWidth()/2, skinMandelbrot:getHeight()/2)
	drawable.circle(
		X,
		Y,
		3
	)
end

function drawDigits(X, Y, color)
	radius = mainCircle.radius
	angle = mainCircle.angle
	deg = 0
	degIncr = degToRad(36)
	textDeg = degToRad(-18)
	textDegIncr = degToRad(36)
	textRad = radius - getPercent(x, 4.6875)

	for i=0,9,1 do
		love.graphics.setFont(button.font1)
		love.graphics.setColor(0,0,0)
		love.graphics.print(
			i,
			X+(textRad*math.sin(deg+degIncr/2-0.75/(2*math.pi))*math.cos(angle) - textRad*math.cos(deg+degIncr/2-0.75/(2*math.pi))*math.sin(angle)), 
			Y+(textRad*math.cos(deg+degIncr/2-0.75/(2*math.pi))*math.cos(angle) + textRad*math.sin(deg+degIncr/2-0.75/(2*math.pi))*math.sin(angle)),
			textDeg + angle
		)
		love.graphics.setFont(button.font)
		love.graphics.setColor(255,255,255)
		love.graphics.print(
			i,
			X+(textRad*math.sin(deg+degIncr/2-0.75/(2*math.pi))*math.cos(angle) - textRad*math.cos(deg+degIncr/2-0.75/(2*math.pi))*math.sin(angle)), 
			Y+(textRad*math.cos(deg+degIncr/2-0.75/(2*math.pi))*math.cos(angle) + textRad*math.sin(deg+degIncr/2-0.75/(2*math.pi))*math.sin(angle)),
			textDeg + angle
		)
		deg = deg + degIncr
		textDeg = textDeg - textDegIncr
	end
end

function rotate()
	mainCircle.angle = mainCircle.angle + 1/math.pi
	if mainCircle.angle > 2 * math.pi then
		mainCircle.angle = mainCircle.angle - 2*math.pi
	end
end

function screens.game.show()

	drawable.triangle(
		mainCircle.X - mainCircle.radius/8, 
		mainCircle.Y + mainCircle.radius + getPercent(x, 2.34375),
		mainCircle.X, 
		mainCircle.Y + mainCircle.radius + getPercent(x, 2.34375)/3,
		mainCircle.X + mainCircle.radius/8, 
		mainCircle.Y + mainCircle.radius + getPercent(x, 2.34375)
	)
	-- if settings.skin == 2 then
	-- 	drawMainCircle(
	-- 		mainCircle.X, 
	-- 		mainCircle.Y, 
	-- 		mainCircle.color
	-- 	)
	-- elseif settings.skin == 1 then
	-- 	drawSwaston(
	-- 		mainCircle.X, 
	-- 		mainCircle.Y
	-- 	)
	-- end
	skinTable[settings.skin].func(
		mainCircle.X, 
		mainCircle.Y, 
		mainCircle.color
	)
	drawDigits(
		mainCircle.X, 
		mainCircle.Y
	)

	if runButtonBlocked then
		button:get("run").color = blockedColor
	else 
		button:get("run").color = button.color
	end

	button:draw("run")

	runButtonBlocked = tern(os.clock()-time<=1.0, true, false)

	if rotateFlag then
		rotate()
		button:get("run").value = "stop"
		if settings.soundOn then
			skinTable[settings.skin].sound:play()
		end
	else
		runButtonBlocked = false
		button:get("run").value = "spin"
		love.audio.stop()
	end
	--topLeft(os.clock()-time)
	--topLeft(mainCircle.angle)
	-- topLeft(answer2)
	
	for i=1, 6, 1 do --number buttons
		button:draw("results" .. i)
	end


	love.graphics.setColor(20, 132, 5)--calc field
	love.graphics.rectangle(
		"fill",
		mainCircle.X - mainCircle.radius,
		button:get("run").Y + button:get("run").height + getPercent(x, 4.125),
		x - 2 * (mainCircle.X - mainCircle.radius), 
		getPercent(x, 5.46875)
	)

	love.graphics.setColor(0, 0, 150)--answer field
	love.graphics.rectangle(
		"fill",
		answerField.X,
		answerField.Y,
		answerField.width,
		answerField.height
	)

	if answer == winAnswer then
		love.graphics.setColor(0,255,0)--answer itself
	else
		love.graphics.setColor(255,0,0)
	end
	love.graphics.setFont(answerFont)

	love.graphics.print( --answer itself
		answer,
		mainCircle.X - mainCircle.radius + 5,
		answerField.Y + answerField.height/2 - answerFont:getHeight()/4
	)

	love.graphics.setColor(50,50,50)--calc string
	love.graphics.setFont(expressionFont)
	love.graphics.print(
		resultString,
		mainCircle.X - mainCircle.radius,
		button:get("run").Y + button:get("run").height + getPercent(x, 4.125) + getPercent(x, 5.46875)/2 - expressionFont:getHeight()/4
	)

	for i=1,2,1 do
		for j=1,5,1 do
			button:draw("operations" .. 5*(i-1)+j)
		end
	end

	button:draw("equal")
	button:draw("skin")
end