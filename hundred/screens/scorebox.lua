screen:new("scorebox", {
	X = x/3,
	Y = y/4,
	w = x/3,
	h = y/2,
	z=2
})
function screen.s.scorebox:show()
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill", 0, 0, self.w, self.h)
	love.graphics.setColor(255,255,255)
	title = "RECORDS"
	love.graphics.setFont(titleFont)
	love.graphics.print(title, self.w/2 - titleFont:getWidth(title)/2, 10)
	love.graphics.print(scoreboard:toString(), 10, titleFont:getHeight(title) * 2)
end