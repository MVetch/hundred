skin = {
	s = {},
	default = {
		unlocked = true,
		img = spincoinPic,
		sound = soundCircle
	}
}

function skin:add(name, params)
	self.s[name] = {}
	if not params then params = {} end
	for k,v in pairs(self.default) do
		self:get(name)[k] = params[k] or v
	end
end

function skin:exists(name)
	return slide:get(name) ~= nil
end

function skin:get(name)
	return self.s[name]
end

skin:add("circle", {
	img = skinCircle
})
skin:add("swaston", {
	img = skinSwaston,
	sound = soundSwaston
})
skin:add("spinner", {
	img = skinSpinner,
	sound = soundSpinner
})
skin:add("alien", {
	img = skinAlien
})
skin:add("handwheel", {
	img = skinHandWheel
})
skin:add("hipno", {
	img = skinHipno
})
skin:add("mandelbrot", {
	img = skinMandelbrot
})