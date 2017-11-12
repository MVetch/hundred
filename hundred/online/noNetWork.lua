function screens.noNetWork.show()
	love.graphics.setColor({0,0,0})--numbers
	str = "Network error! You can train offline."
	love.graphics.print(str, (x - string.width(str, fontSize))*0.5, getPercent(y, 50))
	drawable.button(returnButton)
end