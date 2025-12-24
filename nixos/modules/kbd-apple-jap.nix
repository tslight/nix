{
  # This was a mad layout to figure out! It's a Japanese Layout MBA
  # https://bbs.archlinux.org/viewtopic.php?id=260804
  services.udev.extraHwdb = ''
  evdev:input:b0003v05ACp029*
    KEYBOARD_KEY_70029=capslock
    KEYBOARD_KEY_70039=fn
    KEYBOARD_KEY_70090=leftctrl
    KEYBOARD_KEY_70091=leftctrl
    KEYBOARD_KEY_700e7=leftalt
    KEYBOARD_KEY_700e3=leftalt
    KEYBOARD_KEY_700e2=leftmeta
    KEYBOARD_KEY_700e0=esc
    KEYBOARD_KEY_70089=backspace
    KEYBOARD_KEY_70087=grave
    KEYBOARD_KEY_ff0003=rightmeta
  '';
}
