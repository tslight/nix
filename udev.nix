{ config, ... }:

{
  services.udev.extraHwdb = ''
    # Lenovo ThinkPad T & X series pre 2012
    evdev:atkbd:dmi:bvn*:bvr*:bd*:svnLENOVO:pn*:pvrThinkPad[TWX][246][0-2]*
     KEYBOARD_KEY_01=capslock         # esc   --> caps
     KEYBOARD_KEY_3a=esc              # caps  --> esc
     KEYBOARD_KEY_b8=leftctrl         # altgr --> rctrl
     KEYBOARD_KEY_38=leftctrl         # alt   --> lctrl
     KEYBOARD_KEY_db=leftalt          # lwin  --> lalt
     KEYBOARD_KEY_dd=leftalt          # menu  --> lalt, not altgr (hence left)
     KEYBOARD_KEY_9d=leftmeta         # rctrl --> rwin
     KEYBOARD_KEY_1d=leftmeta         # lctrl --> lwin"
  '';
}
