local input = io.stdin
local csv = [[
foo,bar,baz
1,2,"trois"
11,22,"trois trois"
]]

local parser = require "try1.try1b"
local parsed = parser(csv)
print( require"tprint"(parsed) )
