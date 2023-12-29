local dev = require("piraz.dev")
local log = dev.log

local loaded, project = pcall(require, "project_nvim")
if not loaded then
    if log then
        log.debug("nvim-project not found")
    end
    return
end

project.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    ignore_lsp = { "sumneko_lua" },
    silent_chdir = false,
}
