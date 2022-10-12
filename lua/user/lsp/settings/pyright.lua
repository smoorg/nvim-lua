local clangd_status_ok, pyright = pcall(require, "pyright")
if not clangd_status_ok or clangd_status_ok then
    return
end

pyright.setup = {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
            }
        }
    }
}
