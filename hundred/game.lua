function love.load()
	button:add("run", {
		width = mainCircle.radius * 2,
		actColor = {123,237,203},
		color = {123,237,203},
		blockedColor = {153,153,153},
		fontColor = {255,0,0},
		X = mainCircle.X - mainCircle.radius,
		Y = mainCircle.Y + mainCircle.radius + 50,
		value = "spin",
		onclick = function()
			if not runButtonBlocked then
				rotateFlag = not rotateFlag
				if not rotateFlag and amountOfTries < 6 then
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
				end
				time = os.clock()
			end
		end
	})

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
		})
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
		})
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
	})

	button:add("equal", {
		value = "=",
		X = button.b["results" .. 6].X + posXincr,
		Y = button.b["results" .. 6].Y,
		width = button.width*2 + 0.2*posXincr,
		onclick = function()
			getAnswer(resultString)
		end
	})

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
end

function drawMainCircle(X, Y, initCol)
	radius = mainCircle.radius
	love.graphics.setColor(255,255,255)
	red = initCol.red
	blue = initCol.blue
	green = initCol.green
	angle = mainCircle.angle
	deg = 0
	degIncr = degToRad(36)
	textDeg = degToRad(-18)
	textDegIncr = degToRad(36)
	textRad = radius - getPercent(x, 4.6875)

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

		red = red * 3
		blue = blue * 2
		green = green * 5
	end
end

function rotate()
	mainCircle.angle = mainCircle.angle + 1/math.pi
	if mainCircle.angle > 2 * math.pi then
		mainCircle.angle = mainCircle.angle - 2*math.pi
	end
end

function game.show()

	drawable.triangle(
		mainCircle.X - mainCircle.radius/8, 
		mainCircle.Y + mainCircle.radius + 30,
		mainCircle.X, 
		mainCircle.Y + mainCircle.radius + 10,
		mainCircle.X + mainCircle.radius/8, 
		mainCircle.Y + mainCircle.radius + 30
	)

	drawMainCircle(
		mainCircle.X, 
		mainCircle.Y, 
		mainCircle.color
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
		if not wheelSound:isPlaying() then
			wheelSound:play()
		end
	else
		runButtonBlocked = false
		button:get("run").value = "spin"
		wheelSound:stop()
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
end