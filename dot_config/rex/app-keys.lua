-- App chords. These replace Rex's own shortcuts and sit outside the prefix map.
-- cmd+k was the session picker. It is now focus up, and the picker is cmd+s.

rex.bind("cmd+s", "session.switch")
rex.bind("cmd+h", "pane.focus.left")
rex.bind("cmd+j", "pane.focus.down")
rex.bind("cmd+k", "pane.focus.up")
rex.bind("cmd+l", "pane.focus.right")
