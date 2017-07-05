local re = require"re"

local input = io.stdin

local csvfile = re.compile[[
  records <- {| (record)* |} !.
  record <- {| field (',' field)* |} %nl
  field <- escaped / nonescaped
  nonescaped <- { [^,"%nl]* }
  escaped <- '"' {~ ([^"] / '""' -> '"')* ~} '"'
]]

local parsed = csvfile:match(input:read("*a"))

-- show the result
print("return "..require"tprint"(parsed))	-- in lua
--print(require"json".encode(parsed))		-- in json

