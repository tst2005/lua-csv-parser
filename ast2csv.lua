local renderer = require "ast-renderer"

--local typeget = function(t) return t.tag or t.type end
local ast2csv = renderer("tag")

local csv = ast2csv:defs()

function csv:NonString(t)
	return t[1]
end

function csv:String(t)
	return '"'..t[1]:gsub('"','""')..'"'
end

function csv:Header(t)
	return self:concat(t, ",")
end
function csv:Row(t)
	return self:concat(t, ",")
end

function csv:CsvFile(t)
	return self:concat(t, "\n")
end

return ast2csv
