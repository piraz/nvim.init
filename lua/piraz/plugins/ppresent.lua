local ppresent_src = vim.fs.joinpath(
    vim.uv.os_homedir(),
    "source",
    "piraz",
    "ppresent"
)

local config = {
    start_hook = function(_)
        vim.fn.system('tmux set-option -g status off')
    end,
    end_hook = function(_)
        vim.fn.system('tmux set-option -g status on')
    end,
}

local ppresent = { "piraz/ppresent.nvim", opts={} }
if vim.uv.fs_stat(ppresent_src) then
    ppresent = { "piraz/ppresent.nvim", dir = ppresent_src }
end

ppresent.opts = config
ppresent.keys = {
    { "<leader>pp", function() vim.cmd([[PresentStart]]) end, desc = "Run the PresentStart" },
}

return {
    ppresent
}
