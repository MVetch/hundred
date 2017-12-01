scoreboard = {
	results = {},
	values = 5
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
	for i=1,math.min(table.getn(self.results), self.values),1 do
		res = res .. i .. ". " .. self.results[i] .. "\n"
	end
	return res
end