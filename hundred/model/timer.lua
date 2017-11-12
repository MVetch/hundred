timer = {
	timeStart = 0,
	timeEnd = 0,
	time = 0,
	isGoing = false
}

function timer:start()
	self.timeStart = love.timer.getTime()
	self.isGoing = true
end

function timer:stop()
	self.timeEnd = love.timer.getTime()
	self.time = timer:get()
	self.isGoing = false
end

function timer:get()
	if self.isGoing then
		return string.format("%.2f", love.timer.getTime() - self.timeStart)
	end
	return string.format("%.2f", self.timeEnd - self.timeStart)
end

function timer:reset()
	self.timeStart = self.timeEnd
	self.isGoing = false
end