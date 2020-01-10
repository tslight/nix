{ config, ... }:

{
  services.udev.extraHwdb = ''
    # Microsoft Ergonomic Keyboard 4000
    evdev:input:b0003v045Ep00DB*
     KEYBOARD_KEY_70029=capslock      # esc   --> caps
     KEYBOARD_KEY_70039=esc           # caps  --> esc
     KEYBOARD_KEY_700e2=leftctrl      # alt   --> leftctrl
     KEYBOARD_KEY_700e3=leftalt       # super --> leftalt
     KEYBOARD_KEY_700e0=leftmeta      # ctrl  --> super
     KEYBOARD_KEY_700e6=leftctrl      # altgr --> leftctrl
     KEYBOARD_KEY_70065=leftalt       # menu  --> leftalt
     KEYBOARD_KEY_700e4=leftmeta      # ctrl  --> leftmeta

    # Microsoft Wired USB Keyboard
    evdev:input:b0003v045Ep0752*
     KEYBOARD_KEY_70029=capslock      # esc   --> caps
     KEYBOARD_KEY_70039=esc           # caps  --> esc
     KEYBOARD_KEY_700e2=leftctrl      # alt   --> leftctrl
     KEYBOARD_KEY_700e3=leftalt       # super --> leftalt
     KEYBOARD_KEY_700e0=leftmeta      # ctrl  --> super
     KEYBOARD_KEY_700e6=leftctrl      # altgr --> leftctrl
     KEYBOARD_KEY_700e7=leftalt       # super --> leftalt
     KEYBOARD_KEY_70065=leftmeta      # menu  --> leftmeta
     KEYBOARD_KEY_700e4=menu          # ctrl  --> menu

    # Apple MacBook Pro
    evdev:input:b0003v05ACp0253*
     KEYBOARD_KEY_70029=capslock      # esc       --> caps
     KEYBOARD_KEY_70039=esc           # caps      --> esc
     KEYBOARD_KEY_700e3=leftctrl      # leftcmd   --> leftctrl
     KEYBOARD_KEY_700e7=leftctrl      # rightcmd  --> leftctrl
     KEYBOARD_KEY_700e2=leftalt       # leftopt   --> leftalt
     KEYBOARD_KEY_700e6=leftalt       # rightopt  --> leftalt (to avoid altgr shit)
     KEYBOARD_KEY_700e0=leftmeta      # leftctrl  --> super
     KEYBOARD_KEY_70050=leftmeta      # leftarrow --> super

    evdev:input:b0005v17EFp6048*
     KEYBOARD_KEY_70029=capslock         # esc   --> caps
     KEYBOARD_KEY_70039=esc              # caps  --> esc
     KEYBOARD_KEY_700e2=leftctrl         # alt   --> leftctrl
     KEYBOARD_KEY_700e6=leftctrl         # altgr --> leftctrl
     KEYBOARD_KEY_700e3=leftalt          # super --> leftalt
     KEYBOARD_KEY_70046=leftalt          # prtsc --> leftalt (to avoid altgr shit)
     KEYBOARD_KEY_700e0=leftmeta         # ctrl  --> super
     KEYBOARD_KEY_700e4=leftmeta         # ctrl  --> super

    # Lenovo ThinkPad T & X series post 2012
    evdev:atkbd:dmi:bvn*:bvr*:bd*:svnLENOVO:pn*:pvrThinkPad[TWX][24][3-9]0*
     KEYBOARD_KEY_01=capslock         # esc   --> caps
     KEYBOARD_KEY_3a=esc              # caps  --> esc
     KEYBOARD_KEY_38=leftctrl         # alt   --> leftctrl
     KEYBOARD_KEY_b8=leftctrl         # altgr --> leftctrl
     KEYBOARD_KEY_db=leftalt          # super --> leftalt
     KEYBOARD_KEY_b7=leftalt          # prtsc --> leftalt (to avoid altgr shit)
     KEYBOARD_KEY_1d=leftmeta         # ctrl  --> super
     KEYBOARD_KEY_9d=leftmeta         # ctrl  --> super

    # Lenovo ThinkPad T & X series pre 2012
    evdev:atkbd:dmi:bvn*:bvr*:bd*:svnLENOVO:pn*:pvrThinkPad[TWX][246][0-2]*
     KEYBOARD_KEY_01=capslock         # esc   --> caps
     KEYBOARD_KEY_3a=esc              # caps  --> esc
     KEYBOARD_KEY_b8=leftctrl         # altgr --> rctrl
     KEYBOARD_KEY_38=leftctrl         # alt   --> lctrl
     KEYBOARD_KEY_db=leftalt          # lwin  --> lalt
     KEYBOARD_KEY_dd=leftalt          # menu  --> lalt, not altgr (hence left)
     KEYBOARD_KEY_9d=leftmeta         # rctrl --> rwin
     KEYBOARD_KEY_1d=leftmeta         # lctrl --> lwin

    # HP Probook 430 G6
    evdev:atkbd:dmi:bvn*:bvr*:svnHP*:pnHP*ProBook*430*G6*
     KEYBOARD_KEY_01=capslock         # esc   --> caps
     KEYBOARD_KEY_3a=esc              # caps  --> esc
     KEYBOARD_KEY_38=leftctrl         # alt   --> leftctrl
     KEYBOARD_KEY_db=leftalt          # super --> leftalt
     KEYBOARD_KEY_1d=leftmeta         # ctrl  --> super
     KEYBOARD_KEY_b8=leftctrl         # altgr --> leftctrl
     KEYBOARD_KEY_9d=leftalt          # ctrl  --> leftalt (otherwise altgr)
     KEYBOARD_KEY_cb=leftmeta         # left  --> rightmeta
  '';
}
