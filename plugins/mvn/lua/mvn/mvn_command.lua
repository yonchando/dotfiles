local M = {}

local job = require("mvn.job")

M.run_maven = function(cmd, bufnr, cwd)
    job.run({ bufnr = bufnr, win = -1 }, {
        args = cmd,
        cwd = cwd,
        message_start = "> mvn " .. table.concat(cmd, " ") .. " ",
        message_finish = "> mvn " .. table.concat(cmd, " ") .. " ",
    })
end

return M
