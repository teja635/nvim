vim.api.nvim_create_user_command('GenerateSHA256', function()
  -- Generate a random string (here we use os.time() for simplicity)
  local random_string = tostring(os.time()) .. tostring(math.random())
  
  -- Calculate SHA256 hash using OpenSSL (make sure you have it installed)
  local handle = io.popen("echo -n '" .. random_string .. "' | openssl dgst -sha256")
  local result = handle:read("*a")
  handle:close()

  -- Clean up the result (remove unnecessary text, leaving only the hash)
  local sha256_hash = result:match("%s*(%w+)$")
  
  -- Display the result in Neovim
  vim.api.nvim_put({ sha256_hash }, "l", true, true)
end, {})
