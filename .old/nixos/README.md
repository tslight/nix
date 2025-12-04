For maximum Emacs comfort, I remap my keyboard to conform to the Symbolics'
Lisp Machine keyboard layout. This was the keyboard Emacs' was originally
written on/with.

First thing to do is find out the keyboard evdev indentifier...

Get any keyboard identifier with:

``` shell
cat /proc/bus/input/devices | grep -i keyboard -A 9 -B 1
```

Make sure all the of the keyboard identifier string is capitalised apart from
the section delimiters... `(b****v***p***)`

Get AT laptop keyboards with:

``` shell
cat /sys/class/dmi/id/modalias
```

Next - find the correct keycodes use the `evtest` utility with the path to the
input device as the parameter, eg. `/dev/input/event0`. The keycode is the unique
identifier after the string "value".

One thing to note is that Meta refers to Super in the output from evtest, not
Alt as you might expect.
