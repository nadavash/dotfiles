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

-- Resize the focused pane. A floating pane grows or shrinks inside the window.
-- A pane in the layout moves the split divider, as before.
local FLOAT_MIN = 0.12

local function layer_for(view, block_id)
	for _, window in ipairs(view.windows or {}) do
		for _, layer in ipairs(window.layers or {}) do
			for _, block in ipairs(layer.blocks or {}) do
				if block.block_id == block_id then
					return layer
				end
			end
		end
	end
end

local function fit_float(x, y, w, h)
	if w < FLOAT_MIN then
		w = FLOAT_MIN
	end
	if h < FLOAT_MIN then
		h = FLOAT_MIN
	end
	if w > 1 then
		w = 1
	end
	if h > 1 then
		h = 1
	end
	if x < 0 then
		x = 0
	end
	if y < 0 then
		y = 0
	end
	if x + w > 1 then
		w = 1 - x
	end
	if y + h > 1 then
		h = 1 - y
	end
	return x, y, w, h
end

rex.action({
	name = "resize_focused",
	title = "Resize Focused Pane",
	description = "Resize a floating pane, or move the split divider.",
	repeats = true,
	args = { direction = "string", amount = "number?" },
	run = function(ctx, args)
		local direction = args.direction
		local view, err = rex.session.view({})
		if not view then
			error(err or "could not read the session")
		end
		local layer = layer_for(view, ctx.block_id)
		if layer and layer.kind ~= "tiled" then
			local bounds = layer.bounds
			if not bounds then
				error("floating pane has no size")
			end
			local step = (args.amount or 5) / 100
			local x, y, w, h = bounds[1], bounds[2], bounds[3], bounds[4]
			if direction == "right" then
				w = w + step
			elseif direction == "left" then
				w = w - step
			elseif direction == "down" then
				h = h + step
			elseif direction == "up" then
				h = h - step
			else
				error("unknown direction " .. tostring(direction))
			end
			x, y, w, h = fit_float(x, y, w, h)
			local _, resize_err = rex.session.resize_layer({
				layer_id = layer.layer_id,
				bounds = { x, y, w, h },
			})
			if resize_err then
				error(resize_err)
			end
			return
		end
		local resize_args = { direction = direction }
		if args.amount then
			resize_args.amount = args.amount
		end
		rex.client.queue("pane.resize", resize_args)
	end,
})

-- Resize mode (prefix+r). Arrows and h/j/k/l resize. Enter and escape leave.
rex.mode("resize", { exclusive = true })
rex.bind(seq("r"), "client.mode.enter", { name = "resize" })
rex.bind("resize/enter", "client.mode.exit")
rex.bind("resize/escape", "client.mode.exit")
rex.bind("resize/left", "resize_focused", { direction = "left" })
rex.bind("resize/down", "resize_focused", { direction = "down" })
rex.bind("resize/up", "resize_focused", { direction = "up" })
rex.bind("resize/right", "resize_focused", { direction = "right" })
rex.bind("resize/h", "resize_focused", { direction = "left" })
rex.bind("resize/j", "resize_focused", { direction = "down" })
rex.bind("resize/k", "resize_focused", { direction = "up" })
rex.bind("resize/l", "resize_focused", { direction = "right" })
