local status, gitblame = pcall(require, "gitblame")
if not status then
  return
end


gitblame.setup {
  --Note how the `gitblame_` prefix is omitted in `setup`
  enabled = true,
}
