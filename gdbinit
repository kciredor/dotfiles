# macOS gdb needs this.
set startup-with-shell off

source ~/sec/re/tools/gef.py
source ~/sec/re/tools/venv/lib/python2.7/site-packages/exploitable/exploitable.py

# macOS homebrew gdb is linked against system python. lldb venv workaround does not work. Global voltron install does not work (version conflict, SIP).
# source ~/sec/re/tools/venv/lib/python2.7/site-packages/voltron/entry.py
