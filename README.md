# Minimal Working Nvidia Sleep On NixOS Wayland

A minimal config to at least verify that your hardware can suspend and resume without issues. If it does work, you can gradually incorporate the module options into your configuration. GNOME Wayland in particular seems to be the root/main cause for suspend related issues. Fedora and Ubuntu may have added some patches that allow the same hardware to suspend without issue

## Steps
0. Fix the `FIXME`s and install NixOS
1. Boot into NixOS tty0
2. Login with username and password
3. Run `Hyprland` from the terminal 
4. Press `SUPER` + `Q` to launch `kitty`
5. Run `systemctl suspend` from the terminal 
6. Wake your system with whatever keyboard keypress


## Hardware
Tested on
```
CPU : AMD 5600G
GPU : ASUS DUAL OC RTX3060TI
MoBo: MSI B550M-PRO-VDH
Disp: Dell S2721QS (DisplayPort)
      Acer ED242QR (DisplayPort)
```

# Caveats
There are a few caveats to watch out for.
- Sometimes (around 5% of the time), waking the system via the power button hangs the display stack
  - Can be fixed by SSH and sudo systemctl suspend 
  - And just avoid the power button, use space bar instead

- If the sleep command is issued while both screens are turned off (e.g. via idle), my Dell display's backlight remains on
  - "Fixed" by disabling screen off when idle
