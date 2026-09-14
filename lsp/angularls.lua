local project_lib_path = vim.fn.getcwd() .. "/node_modules"
return {
    cmd = {
        "ngserver",
        "--sdtio",
        "--tsProbeLocations",
        project_lib_path,
        "--ngProbeLocations",
        project_lib_path,
    },
    filetypes = {
        "typescript",
        "html",
        "typescriptreact",
    },
    root_markers = {
        "angular.json",
        "project.json",
        "nx.json",
    },
}
