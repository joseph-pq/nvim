require("dap.ext.vscode").load_launchjs(nil, { debugpy = { "python" } })

local dap_python = require("dap-python")
dap_python.setup("python")
dap_python.test_runner = "pytest"
