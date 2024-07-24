local Dev = require("piraz.dev")
local log = Dev.log

local loaded, chase = pcall(require, "chase")
if loaded then
    chase.setup()
else
    if log then
        log.debug("chase not found")
    end
end
