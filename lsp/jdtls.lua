local root_dir = vim.fs.root(0, { "pom.xml", "build.gradle", "mvnw", "gradlew" })

-- each project needs its own workspace folder
---@diagnostic disable-next-line: param-type-mismatch
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

return {
    cmd = { "jdtls", "-data", workspace_dir },
    root_dir = root_dir,
}
