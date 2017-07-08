local re = require"re"

local input = io.stdin

local csvfile = re.compile[[
  csvfile <- {| {:tag: '' -> "CsvFile" :} hdr (row)+ |} !.
  hdr <- {| {:tag: '' -> "Header" :} fields |} eol
  row <- {| {:tag: '' -> "Row" :} fields |} eol
  fields <- field (',' field)*
  field <- {| escaped / nonescaped |}
  nonescaped <- { [^,"%nl]* } {:tag: '' -> "NonString" :}
  escaped <- '"' {~ ([^"] / '""' -> '"')* ~} '"' {:tag: '' -> "String" :}
  eol <- %nl
]]

local parsed = csvfile:match(input:read("*a"))

-- show the result
local cfg = {}
function cfg.updater(t, lvl, cfg)
        if type(t) == "table" and lvl >= 1 then
                cfg.inline = true
        else
                cfg.inline = false
        end
        return cfg
end

print("return "..require"tprint"(parsed, cfg))	-- in lua
--print(require"json".encode(parsed))		-- in json

