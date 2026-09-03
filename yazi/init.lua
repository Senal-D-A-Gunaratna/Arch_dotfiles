require("recycle-bin"):setup()

require("gvfs"):setup({
	which_keys = "1234567890qwertyuiopasdfghjklzxcvbnm-=[]\\;',./!@#$%^&*()_+{}|:\"<>?",
	password_vault = "keyring", -- needs secret-tool + keyring, or use "pass", or nil
})
