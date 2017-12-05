function string.width(text, fontSize)
	return utf8len(tostring(text))*(fontSize*0.835)
end

function tern ( cond , T , F )
    if cond then return T else return F end
end

function degToRad(deg)
	return deg*math.pi/180
end

function getPercent(value, percents)
	return value * percents / 100
end

function topLeft(value)
	love.graphics.print(value, 0, 0)
end

function bottomLeft(value)
	love.graphics.print(value, y-50, 0)
end

function isLeftParenthesis(token)
	return token == "("
end

function isRightParenthesis(token)
	return token == ")"
end

function isNumber(number)
	return number == "0" or
		number == "1" or
		number == "2" or
		number == "3" or
		number == "4" or
		number == "5" or
		number == "6" or
		number == "7" or
		number == "8" or
		number == "9"
end