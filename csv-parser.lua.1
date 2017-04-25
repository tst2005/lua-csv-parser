local re = require"re"

local input = io.stdin

local record = re.compile[[
  record <- {| field (',' field)* |} (%nl / !.)
  field <- escaped / nonescaped
  nonescaped <- { [^,"%nl]* }
  escaped <- '"' {~ ([^"] / '""' -> '"')* ~} '"'
]]

local parsed = {}
while true do
	local line = input:read("*l")
	if not line then break end
	parsed[#parsed+1]= record:match(line)
end

-- show the result
print("return "..require"tprint"(parsed))	-- in lua
--print(require"json".encode(parsed))		-- in json

