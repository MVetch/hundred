settingsEncoded = love.filesystem.read("settings.txt")
if settingsEncoded then
	settings = json.decode(settingsEncoded)
	if settings.soundOn == nil then
		settings.soundOn = true
	end
	if not settings.skin then
		settings.skin = "circle"
	end
	if not settings.coins then
		settings.coins = 0
	end
else
	settings = {
		soundOn = true,
		skin = "circle",
		coins = 0
	}
end

function settings:set(key, value)
	self[key] = value
	love.filesystem.write("settings.txt", json.encode(settings))
end

function settings:get(key)
	return self[key]
end