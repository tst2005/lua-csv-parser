local re = require"re"

local input = io.stdin

local csvfile = re.compile[[
  csvfile <- {| {:tag: '' -> "csvfile":} hdr (row)+ |} !.
  hdr <- row
  row <- {| {:tag: '' -> "row" :} field (',' field)* |} %nl
  eol <- %nl -- end of line (%nl is newline, "\n")

  field <- escaped / nonescaped
  nonescaped <- { [^,"%nl]* }
  escaped <- '"' {~ ([^"] / '""' -> '"')* ~} '"'
]]

local parsed = csvfile:match(input:read("*a"))

-- show the result
print("return "..require"tprint"(parsed))	-- in lua
--print(require"json".encode(parsed))		-- in json

