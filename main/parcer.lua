require("utf8custom")
outputQueue = {
	data = {}
}

opStack = {
	data = {}
}

operations = {
	{
		value = "+",
		precedence = 1,
		associativity = 0, --0 left, 1 right
		result = function(a, b)
			if b == nil then
				return false
			end
			return a+b
		end
	},
	{
		value = "-",
		precedence = 1,
		associativity = 0, --0 left, 1 right
		result = function(a, b)
			if b == nil then
				return false
			end
			return b-a
		end
	},
	{
		value = "x",
		precedence = 2,
		associativity = 0, --0 left, 1 right
		result = function(a, b)
			if b == nil then
				return false
			end
			return a*b
		end
	},
	{
		value = "/",
		precedence = 2,
		associativity = 0, --0 left, 1 right
		result = function(a, b)
			if b == nil then
				return false
			end
			if a == 0 then 
				return "Error in division function: dividing by 0"
			end
			return b/a
		end
	},
	{
		value = "!",
		precedence = 5,
		associativity = 0, --0 left, 1 right
		result = function(a)
			if a == 0 then
				return 1
			elseif a < 0 then
				return "Error in factorial function: argument should be more than -1"
			else
				ret = 1
				for i=1, a, 1 do
					ret = ret*i
				end
				return ret
			end
		end
	},
	{
		value = "√",
		precedence = 4,
		associativity = 0, --0 left, 1 right
		result = function(a)
			if a<0 then 
				return "Error in sqrt function: argument should be more than 0"
			else
				return math.sqrt(a)
			end
		end
	},
	{
		value = "^",
		precedence = 4,
		associativity = 0, --0 left, 1 right
		result = function(a, b)
			if b == nil then
				return false
			end
			tb=1
			for i=1, a, 1 do
				tb = b*tb
			end
			return tb
		end
	}
}

function getAnswer(expression)
	expression = replaceUnaryOperator(expression)
	--answer = expression
	-- expression = "45"
	-- answer = utf8sub(expression, 20, 20)
	answer = ""
	temp = postfix(expression)
	if temp then -- if error (error is not nil)
		answer = temp
	else 
		if table.getn(outputQueue.data) > 0 then
			--answer = postfixToString(outputQueue)
			answer = evaluate(outputQueue)
			--resultString = resultString.."="..evaluate(outputQueue)
		end
	end

	if answer == 100 then
		if amountOfTries == 6 then end
		love.graphics.setColor(0,255,0)--answer itself
		answer = answer .. "! You won! Click here to try again."
	else
		love.graphics.setColor(255,0,0)
		answer = answer .. "..."
	end

	outputQueue.data = {}
	opStack.data = {}
end

function replaceUnaryOperator(expression)
	expression = string.gsub(expression, '^%-', 'u')
	expression = string.gsub(expression, '%(%-', '(u')
	expression = string.gsub(expression, '^%+', '')
	expression = string.gsub(expression, '%(%+', '(')
	return expression
end

function postfix(expression)
	i=1
	while i <= utf8len(expression) do
		token = utf8sub(expression, i, i)
		if isNumber(token) then
			j=1
			if i < utf8len(expression) then
				while isNumber(utf8sub(expression, i + j, i + j)) do
					token = token .. utf8sub(expression, i + j, i + j)
					j = j + 1
				end
			end
			i = i + j - 1
			outputQueue.push(token)
		elseif isOperation(token) then
			token = isOperation(token)
			if table.getn(opStack.data) > 0 then
				if table.getn(outputQueue.data) > 0 then
					if isOperation(opStack.getTop()) then
						op2 = isOperation(opStack.getTop()) --to get info from operations table
						while 	table.getn(opStack.data) > 0 and (
									(token.associativity == 0 and token.precedence <= op2.precedence) or
									(token.associativity == 1 and token.precedence < op2.precedence)
								) do
							opStack.pop()
							outputQueue.push(op2.value)
							if isOperation(opStack.getTop()) then
								op2 = isOperation(opStack.getTop()) --to get info from operations table
							else 
								break
							end
						end
					end
				end
			end
			opStack.push(token.value)
		elseif token == "u" then--unary minus
			j=1
			if isNumber(utf8sub(expression, i + j, i + j)) then
				token = '-'..utf8sub(expression, i + j, i + j)
				j = j + 1
				while isNumber(utf8sub(expression, i + j, i + j)) do
					token = token .. utf8sub(expression, i + j, i + j)
					j = j + 1
				end
				i = i + j - 1
				outputQueue.push(token)
			else 
				return "Error: number expected after '-'"
			end
		elseif isLeftParenthesis(token) then-- is (
			opStack.push(token)
		elseif isRightParenthesis(token) then-- is )
			while not isLeftParenthesis(opStack.getTop()) do
				outputQueue.push(opStack.getTop())
				opStack.pop()
				if table.getn(opStack.data) == 0 then
					return "mismatched parentheses"
				end
			end
			opStack.pop()
		end
		i=i+1
	end

	for i=1, table.getn(opStack.data), 1 do
		if isLeftParenthesis(opStack.getTop()) then
			return "mismatched parentheses"
		end
		outputQueue.push(opStack.getTop())
		opStack.pop()
	end
end

function postfixToString(queue)
	ret=""
	for i=1, table.getn(queue.data), 1 do
		ret = ret..queue.data[i].." "
	end
	return ret
end

function evaluate(queue)
	ret=""
	Stack = {
		data={},
		push = function (element)
			table.insert(Stack.data, element)
		end,
		pop = function ()
			table.remove(Stack.data)
		end,
		getTop = function ()
			return Stack.data[table.getn(Stack.data)]
		end
	}

	for i=1, table.getn(queue.data), 1 do
		token = queue.data[i]
		if tonumber(token) then
			Stack.push(token)
		elseif isOperation(token) then
			token = isOperation(token)
			if table.getn(Stack.data) > 0 then
				temp = tonumber(Stack.getTop())
				Stack.pop()
				if token.result(temp) then
					ret = token.result(temp) 
				elseif token.result(temp, Stack.getTop()) then
					ret = token.result(temp, Stack.getTop())
					Stack.pop()
					else return "Error: wrong operation order"
				end
				if not tonumber(ret) then 
					ret = tostring(ret) 
					Stack.push(ret)
					break 
				end
				Stack.push(ret)
				else return "Error: too many operators"
			end
		end
	end
	if table.getn(Stack.data) == 1 then
		return Stack.getTop()
		else return "Error: too few operators"
	end
end

function isLeftParenthesis(token)
	return token == "("
end

function isRightParenthesis(token)
	return token == ")"
end

function isNumber(number)
	if number == "0" or
		number == "1" or
		number == "2" or
		number == "3" or
		number == "4" or
		number == "5" or
		number == "6" or
		number == "7" or
		number == "8" or
		number == "9" then
		return true
		else return false
	end
end

function isOperation(token)
	for i=1, table.getn(operations), 1 do
		if token == operations[i].value then
			return operations[i]
		end
	end
	return false
end

function outputQueue.pop()
	table.remove(outputQueue.data)
end

function outputQueue.push(element)
	table.insert(outputQueue.data, element)
end

function opStack.pop()
	table.remove(opStack.data)
end

function opStack.push(element)
	table.insert(opStack.data, element)
end

function opStack.getTop()
	return opStack.data[table.getn(opStack.data)]
end

function outputQueue.getLast()
	return outputQueue.data[table.getn(outputQueue.data)]
end