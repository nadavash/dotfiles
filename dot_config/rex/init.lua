-- Herdr prefix shortcuts. Change prefix to move every shortcut below.
-- prefix+c is prefix followed by c. Pressing the prefix twice still reaches
-- the program in the pane.
-- Herdr workspaces are Rex sessions. Herdr tabs and panes are Rex tabs and panes.
local prefix = "ctrl+b"

local function seq(key)
	return prefix .. ">" .. key
end

rex.bind(seq(prefix), "pane.send_key", { key = prefix })

-- Workspaces
rex.bind(seq("g"), "pane.go_to")
rex.bind(seq("shift+n"), "session.new")
rex.bind(seq("shift+w"), "session.rename")
rex.bind(seq("shift+d"), "session.close")
rex.bind(seq("s"), "client.settings")
rex.bind(seq("shift+r"), "client.config.reload")
rex.bind(seq("b"), "client.sidebar.toggle")

-- Change tabs: prefix+w, then j for the next tab and k for the previous.
-- Enter and escape leave the mode.
rex.mode("change-tabs", { exclusive = true })
rex.bind(seq("w"), "client.mode.enter", { name = "change-tabs" })
rex.bind("change-tabs/j", "client.tab.next")
rex.bind("change-tabs/k", "client.tab.previous")
rex.bind("change-tabs/enter", "client.mode.exit")
rex.bind("change-tabs/escape", "client.mode.exit")

-- Tabs
rex.bind(seq("c"), "client.tab.new")
rex.bind(seq("n"), "client.tab.next")
rex.bind(seq("p"), "client.tab.previous")
rex.bind(seq("shift+t"), "client.tab.rename")
rex.bind(seq("shift+x"), "client.tab.close")
for tab = 1, 9 do
	rex.bind(seq(tab), "client.tab.goto", { index = tab })
end

-- Panes
rex.bind(seq("h"), "pane.focus.left")
rex.bind(seq("j"), "pane.focus.down")
rex.bind(seq("k"), "pane.focus.up")
rex.bind(seq("l"), "pane.focus.right")
rex.bind(seq("tab"), "pane.focus_next")
rex.bind(seq("shift+tab"), "pane.focus_previous")
rex.bind(seq("v"), "pane.split", { direction = "right" })
rex.bind(seq("-"), "pane.split", { direction = "down" })
rex.bind(seq("x"), "pane.close")
rex.bind(seq("z"), "pane.zoom")
rex.bind(seq("shift+p"), "pane.rename")
-- Herdr swaps the neighbor; Rex moves the focused pane that way.
rex.bind(seq("shift+h"), "pane.move.left")
rex.bind(seq("shift+j"), "pane.move.down")
rex.bind(seq("shift+k"), "pane.move.up")
rex.bind(seq("shift+l"), "pane.move.right")

-- Resize mode (prefix+r). Arrows resize. Enter and escape leave the mode.
rex.mode("resize", { exclusive = true })
rex.bind(seq("r"), "client.mode.enter", { name = "resize" })
rex.bind("resize/enter", "client.mode.exit")
rex.bind("resize/escape", "client.mode.exit")
rex.bind("resize/left", "pane.resize", { direction = "left" })
rex.bind("resize/down", "pane.resize", { direction = "down" })
rex.bind("resize/up", "pane.resize", { direction = "up" })
rex.bind("resize/right", "pane.resize", { direction = "right" })
rex.bind("resize/h", "pane.resize", { direction = "left" })
rex.bind("resize/j", "pane.resize", { direction = "down" })
rex.bind("resize/k", "pane.resize", { direction = "up" })
rex.bind("resize/l", "pane.resize", { direction = "right" })
