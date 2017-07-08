
local ast2csv = require "ast2csv"

if (...) == "-" then
	local tmpenv = {}
	local luacode = "local t;(function() "..io.stdin:read("*a").."end)();return t"
	local load = loadstring or load
	local t = load(luacode, luacode, "t", tmpenv)()
	--print("t = "..require"tprint"(t, {inline=false}))
	print(ast2csv:render(t))
	return
end

