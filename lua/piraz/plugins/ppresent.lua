local Dev = require("piraz.dev")

local ppresent_src = table.concat({
    vim.fn.environ()['HOME'], "source", "piraz", "ppresent"
}, Dev.sep)

local config = {
    start_hook = function(_)
        vim.fn.system('tmux set-option -g status off')
    end,
    end_hook = function(_)
        vim.fn.system('tmux set-option -g status on')
    end,
}

local ppresent = { "piraz/ppresent.nvim", opts={} }
if Dev.path_exists(ppresent_src) then
    ppresent = { "piraz/ppresent.nvim", dir = ppresent_src }
end

ppresent.opts = config
ppresent.keys = {
    { "<leader>pp", function() vim.cmd([[PresentStart]]) end, desc = "Run the PresentStart" },
}

return {
    ppresent
}
