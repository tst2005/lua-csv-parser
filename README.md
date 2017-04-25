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

You get the first sample ([try1a.lua](try/try1a.lua)) :
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

We get ([try1b.lua](try/try1b.lua)) :
```lua
local field = '"' * lpeg.Cs(((lpeg.P(1) - '"') + lpeg.P'""' / '"')^0) * '"' +
                    lpeg.C((1 - lpeg.S',\n"')^0)

local record = lpeg.Ct(field * (',' * field)^0) * (lpeg.P'\n' + -1)

function csv (s)
  return lpeg.match(record, s)
end
```




# 2. with LPeg.re

# 2.a.

# 2.b.

# 2.c.

# 2.d.


