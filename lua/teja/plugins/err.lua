local M = {}

-- Helper function to determine the default Go value based on type
local function get_default_value(go_type)
  local default_values = {
    int = "0",
    int8 = "0",
    int16 = "0",
    int32 = "0",
    int64 = "0",
    float32 = "0.0",
    float64 = "0.0",
    bool = "false",
    string = '""',
  }
  -- Return "nil" for other types (e.g., pointers, interfaces, slices, maps)
  return default_values[go_type] or "nil"
end

-- Generic function to insert error handling with custom error type
local function insert_error_handling_with_type(error_function, should_return)
  local line = vim.api.nvim_get_current_line()
  local indentation = line:match("^%s*") or ""
  local pattern = "(.+), err := (.+)%((.*)%)"
  local returns, function_call, args = line:match(pattern)

  if returns and function_call and args then
    vim.lsp.buf_request(0, "textDocument/hover", vim.lsp.util.make_position_params(), function(err, result)
      if err or not result then
        print("LSP request failed or no result")
        return
      end

      local hover_text = result.contents.value
      local return_types = {}
      for return_type in hover_text:gmatch("(%w+)[,)%]]") do
        table.insert(return_types, return_type)
      end

      local default_returns = {}
      for _, go_type in ipairs(return_types) do
        table.insert(default_returns, get_default_value(go_type))
      end

      local formatted_returns
      if #return_types == 1 and return_types[1] == "error" then
        formatted_returns = ""
      else
        formatted_returns = table.concat(default_returns, ", ")
      end

      -- Generate the error-handling block based on should_return
      local error_handling = { string.format('%sif err != nil {', indentation) }
      if should_return then
        table.insert(error_handling, string.format('%s  return %s %s("%s: %%w", err)', indentation, formatted_returns, error_function, function_call))
      else
        table.insert(error_handling, string.format('%s  %s("%s: %%v", err)', indentation, error_function, function_call))
      end
      table.insert(error_handling, string.format('%s}', indentation))

      local current_line_number = vim.api.nvim_win_get_cursor(0)[1]
      vim.api.nvim_buf_set_lines(0, current_line_number, current_line_number, false, error_handling)
    end)
  else
    print("No matching pattern found")
  end
end

-- Different functions for each error-handling type
function M.generate_error_newf()
  insert_error_handling_with_type("errors.Newf", true)
end

function M.generate_log_infof()
  insert_error_handling_with_type("log.Infof", false)
end

function M.generate_log_fatalf()
  insert_error_handling_with_type("log.Fatalf", false)
end

-- Create commands for each error-handling type
vim.api.nvim_create_user_command('GenerateErrorHandlingErrors', M.generate_error_newf, {})
vim.api.nvim_create_user_command('GenerateErrorHandlingInfo', M.generate_log_infof, {})
vim.api.nvim_create_user_command('GenerateErrorHandlingFatal', M.generate_log_fatalf, {})

