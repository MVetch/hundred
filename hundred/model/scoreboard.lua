scoreboard = {
	results = {},
	values = 10
}

function scoreboard:load()
	recordsEncoded = love.filesystem.read("records.txt")
	if recordsEncoded then
		self.results = json.decode(recordsEncoded)
	else
		self.results = {}
	end
end

function scoreboard:write(value)
	table.insert(self.results, value)
	table.sort(self.results)
	if table.getn(self.results) > self.values then
		table.remove(self.results)
	end
end

function scoreboard:toString()
	res = ""
	for i=1,table.getn(self.results),1 do
		res = res .. self.results[i] .. "\n"
	end
	topLeft(res)
end

function screens.scorebox.show()
	love.graphics.translate(screens.scorebox.X, screens.scorebox.Y)
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill", 0, 0, screens.scorebox.w, screens.scorebox.h)
	love.graphics.setColor(255,255,255)
	scoreboard:toString()
	love.graphics.origin()
end