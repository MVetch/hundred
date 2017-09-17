menu = {draw = true}
function properties()
	--love.window.setMode(0, 0, {resizable = false, borderless=true})
	love.window.setMode(1280, 720, {resizable = false, borderless=false})
	x=love.graphics.getWidth()
	y=love.graphics.getHeight()

	fontSize = 40

	flags = {
		0,--Fullscreen (true), or windowed (false)
		"desktop",--The type of fullscreen to use. This defaults to "normal" in 0.9.2 and older.
		1,--True if LÖVE should wait for vsync, false otherwise.
		0,--The number of antialiasing samples
		0,--True if the window should be resizable in windowed mode, false otherwise.
		1,--True if the window should be borderless in windowed mode, false otherwise.
		1,--True if the window should be centered in windowed mode, false otherwise.
		1,--The index of the display to show the window in, if multiple monitors are available.
		1,--The minimum width of the window, if it's resizable. Cannot be less than 1.
		1,--The minimum height of the window, if it's resizable. Cannot be less than 1.
		0,--True if high-dpi mode should be used on Retina displays in OS X and iOS. Does nothing on non-Retina displays. Added in 0.9.1.
		nil,--The x-coordinate of the window's position in the specified display. Added in 0.9.2.
		nil,--The y-coordinate of the window's position in the specified display. Added in 0.9.2.
		1--True if sRGB gamma correction should be applied when drawing to the screen. Added in 0.9.1.
	}

	closeButton = {
		X = x-40,
		Y = 0,
		width = 40,
		height = 40,
		value = "x"
	}

	BackgroundColor = {255,100,100}
	love.graphics.setBackgroundColor(BackgroundColor)

	button = {
		width = 100,
		height = 50,
		color = {123,237,203},
		font = love.graphics.newFont("runFont.ttf", fontSize),
		fontColor = {255,0,0}
	}

	playOfflineButton = {
		X = x/2 - 530/2,
		Y = y/2 + 50,
		width = 530,
		height = 50,
		color = button.color,
		value = "Play offline",
		textColor = BackgroundColor,
		textColorClicked = {255,0,0} 
	}

	playOnlineButton = {
		X = x/2 - 530/2,
		Y = y/2 - 50,
		width = 530,
		height = 50,
		color = button.color,
		value = "Play online",
		textColor = BackgroundColor,
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
end

require "drawable"

function drawCloseButton()
	love.graphics.setColor(255,0,0)
	love.graphics.rectangle("fill", x-closeButton.width, 0, closeButton.width, closeButton.height)
	love.graphics.setColor(BackgroundColor)
	love.graphics.setFont(button.font)
	love.graphics.print(closeButton.value, closeButton.X + 3, closeButton.Y + 5)
end

function drawButton(x, y, value, textColor)
	love.graphics.setColor(button.color)--number buttons
	love.graphics.rectangle(
		"fill", 
		x, 
		y, 
		button.width, 
		button.height,
		10,
		10,
		40
	)

	love.graphics.setColor(textColor)--numbers
	love.graphics.setFont(button.font)
	love.graphics.print(value, x+30, y+15)
end

function drawPlayOfflineButton()
	love.graphics.setColor(playOfflineButton.color)--number buttons
	love.graphics.rectangle(
		"fill", 
		playOfflineButton.X, 
		playOfflineButton.Y, 
		playOfflineButton.width, 
		playOfflineButton.height,
		10,
		10,
		40
	)

	love.graphics.setColor(playOfflineButton.textColor)--numbers
	love.graphics.setFont(button.font)
	love.graphics.print(playOfflineButton.value, playOfflineButton.X+30, playOfflineButton.Y+15)
end

function drawPlayOnlineButton()
	love.graphics.setColor(playOnlineButton.color)--number buttons
	love.graphics.rectangle(
		"fill", 
		playOnlineButton.X, 
		playOnlineButton.Y, 
		playOnlineButton.width, 
		playOnlineButton.height,
		10,
		10,
		40
	)

	love.graphics.setColor(playOnlineButton.textColor)--numbers
	love.graphics.setFont(button.font)
	love.graphics.print(playOnlineButton.value, playOnlineButton.X+50, playOnlineButton.Y+15)
end

function menu.show()
	drawPlayOfflineButton()
	drawPlayOnlineButton()
	drawable.button(
		x-closeButton.width,
		0,
		closeButton.width,
		closeButton.height,
		closeButton.value,
		{255, 0, 0}
	)
end