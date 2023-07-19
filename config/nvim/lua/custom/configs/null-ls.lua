local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local format = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {

	-- webdev stuff
  format.deno_fmt,-- chose deno for ts/js files cuz its very fast!
  format.prettier.with { filetypes = { "html", "markdown", "css" } },-- so prettier works only on these filetypes

	-- Lua
  format.stylua,

	-- Python
	format.black,
	format.isort,

  -- Shell
  format.shfmt,
  lint.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- cpp
  format.clang_format,

	-- rust
	format.rustfmt,

	-- toml
	format.taplo,

	-- yaml
	format.yamlfmt,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
