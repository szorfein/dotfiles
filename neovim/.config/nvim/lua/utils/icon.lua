local M = {}

function M.get(name)
    local i = {
        Diagnostic = '󰒡',
        DiagnosticError = '',
        DiagnosticHint = '󰌵',
        DiagnosticInfo = '󰋼',
        DiagnosticWarn = '',
    }
    return i[name]
end

return M
