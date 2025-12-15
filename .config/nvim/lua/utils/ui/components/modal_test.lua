local Modal = require("utils.ui.components.modal")

function _G.CreateModal()
	Modal.View({
		width = 50,
		height = 10,
		border = "single",
		padding = { top = 1, right = 2, bottom = 1, left = 2 },
		lines = { "Hello UI", "This is inside a padded box." },
	})
end
