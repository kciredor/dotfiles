# macOS gdb needs entitlements: https://sourceware.org/gdb/wiki/PermissionsDarwin

# macOS gdb needs this.
set startup-with-shell off

# XXX: Python Exception <type 'exceptions.OSError'> CPU type is currently not supported: i386:x86-64:
# source ~/sec/re/tools/gef.py
# source ~/sec/re/tools/venv/lib/python2.7/site-packages/exploitable/exploitable.py

# XXX: segfaults gdb when 'r' target?! -> https://www.cygwin.com/bugzilla/show_bug.cgi?id=24593 -> brew install --HEAD gdb -> build error
# layout regs

# XXX: macOS homebrew gdb is linked against system python. lldb venv workaround does not work. Global voltron install does not work (version conflict, SIP).
# source ~/sec/re/tools/venv/lib/python2.7/site-packages/voltron/entry.py
