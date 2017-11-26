function screen.s.scorebox.show()
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill", 0, 0, screen.s.scorebox.w, screen.s.scorebox.h)
	love.graphics.setColor(255,255,255)
	scoreboard:toString()
end