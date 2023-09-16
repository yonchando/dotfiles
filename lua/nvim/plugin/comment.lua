local status_ok, comment = pcall(require,"neodev")
if not status_ok then
    return
end

comment.setup()
