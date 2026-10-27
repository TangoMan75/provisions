Prime-select intel is not powering off the nvidia card
======================================================

https://github.com/stockmind/dell-xps-9560-ubuntu-respin/issues/8#issuecomment-389292575

Running sudo powertop gave me a power usages of about 15W in idle, indicating that the GPU was still on, even after prime-select intel.

I kept powertop running and in another terminal ran:

```bash
$ cat /sys/bus/pci/devices/0000\:01\:00.0/power/control
# resulted in "on", which is not good
```

I then executed (see bug report):

```bash
sudo sh -c 'echo auto > /sys/bus/pci/devices/0000\:01\:00.0/power/control'
```

Powertop dropped to about 6W ! ))
So then it was simple, created this startup script to make the change permanent:

```bash
$ sudo nano /lib/systemd/system/gpuoff.service
```

And pasted contents:

```
[Unit]
Description=Power-off gpu

[Service]
Type=oneshot
ExecStart=/bin/bash -c "if [[ `prime-select query` == 'intel' ]]; then echo auto > /sys/bus/pci/devices/0000\:01\:00.0/power/control; fi"

[Install]
WantedBy=default.target
```

To test the script you can run 
```bash
$ sudo systemctl start gpuoff
```

If ok, run 
```bash
$ sudo systemctl enable gpuoff
```
to enable the script to start on powerup.

To confirm that it works
```bash
$ cat /sys/bus/pci/devices/0000\:01\:00.0/power/control
```
should return: "auto" after reboot.

PS For what it is worth, my /etc/default/grub line is:

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash i915.modeset=1 nouveau.modeset=0"
```

