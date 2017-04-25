# csv-parser

# For me

This is an experimental project to improve my LPeg/LPeg.re/parser/lexer/... skills.
I started from something simple : parsing a CSV file!

# For you

I publish my own sample of code, make step by step...
I hope it will be usefull for someone else.

# my tries

# 1 with LPeg

## 1.a. LPeg sample from doc

See ["the Comma-Separated Values (CSV)" sample](http://www.inf.puc-rio.br/~roberto/lpeg/lpeg.html#CSV).

You get the first sample ([try1a.lua](try1/try1a.lua)) :
```lua
local field = '"' * lpeg.Cs(((lpeg.P(1) - '"') + lpeg.P'""' / '"')^0) * '"' +
                    lpeg.C((1 - lpeg.S',\n"')^0)

local record = field * (',' * field)^0 * (lpeg.P'\n' + -1)

function csv (s)
  return lpeg.match(record, s)
end
```

# 1.b. LPeg sample from doc (bis)

The doc say we can capture values into a table. Just change the record definition :
```diff
-local record =         field * (',' * field)^0  * (lpeg.P'\n' + -1)
+local record = lpeg.Ct(field * (',' * field)^0) * (lpeg.P'\n' + -1)
```

We get ([try1b.lua](try1/try1b.lua)) :
```lua
local field = '"' * lpeg.Cs(((lpeg.P(1) - '"') + lpeg.P'""' / '"')^0) * '"' +
                    lpeg.C((1 - lpeg.S',\n"')^0)

local record = lpeg.Ct(field * (',' * field)^0) * (lpeg.P'\n' + -1)

function csv (s)
  return lpeg.match(record, s)
end
```




# 2. with LPeg.re

# 2.a. LPeg parse only one line at a time

Lua code is used to get lines from the input and add the parsed line result into a table.

```lua
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
```

Run: `lua csv-parser.lua.1 < sample.csv`
See files :
* [csv-parser.lua.1](csv-parser.lua.1)
* [sample.csv](sample.csv)

Get the result:
```lua
return {
	[1] = {
		[1] = "foo",
		[2] = "bar",
		[3] = "baz",
	},
	[2] = {
		[1] = "1",
		[2] = "2",
		[3] = "trois",
	},
	[3] = {
		[1] = "11",
		[2] = "22",
		[3] = "trois trois",
	},
}
```

# 2.b. 

We add a `records` = some `record` to parse the entire file without extra lua code.

```lua
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
```

Run: `lua csv-parser.lua.2 < sample.csv`
See files :
* [csv-parser.lua.2](csv-parser.lua.2)
* [sample.csv](sample.csv)

Get the result:
```lua
return {
	[1] = {
		[1] = "foo",
		[2] = "bar",
		[3] = "baz",
	},
	[2] = {
		[1] = "1",
		[2] = "2",
		[3] = "trois",
	},
	[3] = {
		[1] = "11",
		[2] = "22",
		[3] = "trois trois",
	},
}
```

# 2.c. result in AST

```lua
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
```

Run: `lua csv-parser.lua.3 < sample.csv`
See files :
* [csv-parser.lua.3](csv-parser.lua.3)
* [sample.csv](sample.csv)

Get the result:
```lua
return {
	[1] = {
		[1] = "foo",
		[2] = "bar",
		[3] = "baz",
		["tag"] = "row",
	},
	[2] = {
		[1] = "1",
		[2] = "2",
		[3] = "trois",
		["tag"] = "row",
	},
	[3] = {
		[1] = "11",
		[2] = "22",
		[3] = "trois trois",
		["tag"] = "row",
	},
	["tag"] = "csvfile",
}
```

# 2.d.


