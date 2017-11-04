menu = {draw = false}

x = love.graphics.getWidth()
y = love.graphics.getHeight()

fontSize = getPercent(x, 3.125)


BackgroundColor = {252, 15, 192}
love.graphics.setBackgroundColor(BackgroundColor)

button = {
	width = getPercent(x, 7.8125),
	height = getPercent(x, 3.90625),
	color = {123,237,203},
	font = love.graphics.newFont("joystix monospace.ttf", fontSize),
	font1 = love.graphics.newFont("joystix monospace.ttf", fontSize + 3),
	fontColor = {255,0,0}
}

closeButton = {
	X = x-button.width/2,
	Y = 0,
	width = button.width/2,
	height = button.height,
	value = "x",
	color = {255, 0, 0}
}

playOfflineButton = {
	X = x/2 - getPercent(x, 41.40625)/2,
	Y = y/2 + button.height,
	width = getPercent(x, 41.40625),
	height = button.height,
	color = button.color,
	value = "Play offline",
	textColorClicked = {255,0,0} 
}

playOnlineButton = {
	X = playOfflineButton.X,
	Y = playOfflineButton.Y,
	width = playOfflineButton.width,
	height = playOfflineButton.height,
	color = playOfflineButton.color,
	value = "Play online",
	textColorClicked = playOfflineButton.textColorClicked
}

returnButton = {
	X = getPercent(x, 0.78125),
	Y = getPercent(x, 0.78125),
	width = button.width * 5,
	height = button.height,
	color = button.color,
	value = "Return",
	textColor = BackgroundColor,
	textColorClicked = {255,0,0} 
}

function menu.show()
	drawable.button(playOfflineButton)
	drawable.button(playOnlineButton)
end