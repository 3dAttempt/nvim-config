-- Ignore diagnostic messages that are shown as errors, but aren't actually any

local M = {}

M.ignored_messages = {
  { "gson", "cannot be resolved" },
  { "com.google.gson.gson", "is not accessible" },

}

M.should_ignore = function (message)
  local msg = message:lower()
  for _, patterns in ipairs(M.ignored_messages) do
    local all_match = true
    for _, pattern in ipairs(patterns) do
      if not msg:match(pattern) then
        all_match = false
        break
      end
    end
    if all_match then
      return true
    end
  end
  return false
end

return M
