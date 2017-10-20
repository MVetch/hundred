menu = {draw = true}

x = love.graphics.getWidth()
y = love.graphics.getHeight()

fontSize = 40

closeButton = {
	X = x-50,
	Y = 0,
	width = 50,
	height = 50,
	value = "x",
	color = {255, 0, 0}
}

BackgroundColor = {255,100,100}
love.graphics.setBackgroundColor(BackgroundColor)

button = {
	width = 100,
	height = 50,
	color = {123,237,203},
	font = love.graphics.newFont("joystix monospace.ttf", fontSize),
	fontColor = {255,0,0}
}

playOfflineButton = {
	X = x/2 - 530/2,
	Y = y/2 + 50,
	width = 530,
	height = 50,
	color = button.color,
	value = "Play offline",
	textColorClicked = {255,0,0} 
}

playOnlineButton = {
	X = x/2 - 530/2,
	Y = y/2 - 50,
	width = 530,
	height = 50,
	color = button.color,
	value = "Play online",
	textColorClicked = {255,0,0} 
}

returnButton = {
	X = 10,
	Y = 10,
	width = 50 + 6*40,
	height = 50,
	color = button.color,
	value = "Return",
	textColor = BackgroundColor,
	textColorClicked = {255,0,0} 
}
require "drawable"

function menu.show()
	drawable.button(playOfflineButton)
	drawable.button(playOnlineButton)
end