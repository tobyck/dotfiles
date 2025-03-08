local config = {
	cmd = {
		"jdtls",
		"-configuration",
		vim.env.HOME .. "/.cache/jdtls/config",
		"-data",
		vim.env.HOME .. "/.cache/jdtls/workspace"
	},
	root_dir = vim.fs.dirname(
		vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]
	),
}

require('jdtls').start_or_attach(config)
