local Dev = require("piraz.dev")
local log = Dev.log


local loaded, chase = pcall(require, "chase")
if loaded then
    local chasepy = require("chase.python")
    chase.setup()
    chasepy.setup()
else
    log.debug("chase not found")
end
