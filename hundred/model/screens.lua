screens = {
}

screen = {
	default = {
		X = 0,
		Y = 0,
		w = x,
		h = y,
		draw = false
	},
	s = {}
}

function screen:new(name, params)
	self.s[name] = {}
	if not params then params = {} end
	for k,v in pairs(screen.default) do
		self.s[name][k] = params[k] or v
	end
	self.s[name].buttons = {}
end

function screen:show(name)
	if name == nil then error("oops") end
	love.graphics.translate(screen:get(name).X, screen:get(name).Y)
	screen:get(name).show()
	love.graphics.origin()
end

function screen:get(name)
	if not screen:exists(name) then
		error("screen " .. name .. " doesn't exist")
	end
	return self.s[name]
end

function screen:exists(name)
	return self.s[name] ~= nil
end
screen:new("scorebox", {
	zindex = 2,
	X = x/3,
	Y = y/4,
	w = x/3,
	h = y/2
})
screen:new("coincount",{
	draw = true,
	X = x-150,
	Y = 70,
	w = 150,
	h = 100
})
screen:new("game",{
	draw = true
})
screen:new("menu")
screen:new("noNetWork")
screen:new("wait")
screen:new("background",{
	draw = true,
})