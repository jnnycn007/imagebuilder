# some notes about running xorg with the nouveau gpu driver on nyan

- out of the box xorg does not work well or not at all together with the
  nouveau gpu driver (the actual situation seems to depend on kernel, mesa and
xorg version)
- the easiest solution (and the one used in the nyan images by default) is to
  simply disable gpu accel by using
/etc/X11/xorg.conf.d.samples/11-modesetting-no-glamor.conf as xorg config -
this works out of the box, but has not gpu accel
- there was some ugly hack to at least not let everything using the gpu via
  mesa crash with an assertation by simply dropping this assertation and
living with the resulting rendering errors - not sure if this is still an
option with recent kernels, xorg and mesa versions - this is that hack:
https://github.com/hexdump0815/mesa-etc-build/blob/131236e29392debc903e08a986ae99d9f97b38d5/tegra-hack.patch
and it comes from the issue 3505 mentioned in the links section below
- another solution was to build the dev version of the xorg server of around
  early 2021 and use that instead of the dist xorg server, this worked quite
ok, but ran into strange memory allocation errors on 4gb ram nyan systems
(again see the below mentioned issue 3505 for more details)
- this xorg server dev build requires some extra input config files for the
  nyan big keyboard and usb keyboard and mouse to work:
/etc/X11/xorg.conf.d.samples/51-newer-xorg-chromebook-kbd.conf and
/etc/X11/xorg.conf.d.samples/51-newer-xorg-old-input.conf
- the xorg server coming with bookworm currently (1.21.1.4) does not seem to
  work with mesa 22.x resulting in some strange alocation errors etc. even
with glxgears and glmark2
- a try to build the current dev version of the xorg server (21.1.99
  currently) did not work neither - some info about building the xorg dev
version and the resulting warnings and errors can be found here:
https://github.com/hexdump0815/mesa-etc-build/blob/03cc0e72b94529600f24a027158c3bc94034a933/xserver-build.txt
- it looks like the working old bullseye xorg server seems to work on bookworm
  as well if the bullseye input drivers are put into the package as well -
those xserver builds and some versions for bookworm/jammy with the
bullseye/focal input dirvers included can be found here:
https://github.com/hexdump0815/mesa-etc-build/releases/tag/21.0.1
- some links which might be interesting or relevant:
  - https://gitlab.freedesktop.org/mesa/mesa/-/issues/3505
  - https://gitlab.freedesktop.org/mesa/mesa/-/issues/6693
    - via: https://wiki.postmarketos.org/wiki/Acer_Chromebook_13_CB5-311_(google-nyan-big)
- in case someone finds out more or gets something working reliable and easily
  to reproduce, please open a github issue on this repo and share whatever new
or additional information is available
- it looks like the working old xorg server and mesa seems to work on trixie even still :)
  - some notes upfront:
    - even this old gpu driver is broken, so be happy if something is working
      and expect anything a bit more complex opengl/gles to not work due to
this brokenness of the driver
    - do not even think about running stuff like gnome or kde etc. on top of
      this
    - some simple stuff like glmark2 seems to work ok
    - more complex programs which use opengl/gles like firefox should be run
      like: "env LIBGL_ALWAYS_SOFTWARE=1 firefox" to explicitely disable the
gpu support as otherwise they are likely to crash sooner or later
    - this old xserver and mesa builds most probably have some security issues
      in them which are only fixed in newer version, so do not use this stuff
for anything where security matters
- steps to switch to the old xorg and mesa on trixie (verified to work with the autumn 2026 nyan image):
```
# the below steps have to be run as root in some dir - maybe /root for instance
sudo -i
cd /root
# this is to avoid anything done in the nexts steps to be overwritten by updating those packages
apt-mark hold libgl1-mesa-dri mesa-va-drivers xserver-xorg-core
# get the old mesa and xorg server builds plus the old shared libraries they depend on
wget https://github.com/hexdump0815/mesa-etc-build/releases/download/21.0.1/opt-xserver-bookworm-armv7l.tar.gz
wget https://github.com/hexdump0815/mesa-etc-build/releases/download/21.0.3/opt-mesa-21.0.3-bookworm-armv7l.tar.gz
wget https://github.com/hexdump0815/mesa-etc-build/releases/download/21.0.1/nyan-oldlibs.tar.gz
# install them by unpacking the archives - all stuff goes to /opt plus /etc/ld.so.conf.d/aaa-oldlibs.conf
cd /
tar xzf /root/opt-xserver-bookworm-armv7l.tar.gz
tar xzf /root/opt-mesa-21.0.3-bookworm-armv7l.tar.gz
tar xzf /root/nyan-oldlibs.tar.gz
# change some things to make the system use the old versions instead of the regular new ones
mv -v /usr/lib/xorg/Xorg /usr/lib/xorg/Xorg.org
ln -s /opt/xserver/bin/Xorg /usr/lib/xorg/Xorg
mv -v /usr/lib/arm-linux-gnueabihf/dri /usr/lib/arm-linux-gnueabihf/dri.org
ln -s /opt/mesa/lib/arm-linux-gnueabihf/dri /usr/lib/arm-linux-gnueabihf/dri
mv -v /etc/X11/xorg.conf.d /etc/X11/xorg.conf.d.org
mkdir /etc/X11/xorg.conf.d
cp /etc/X11/xorg.conf.d.samples/11-modesetting.conf /etc/X11/xorg.conf.d
cp /etc/X11/xorg.conf.d.samples/13-nouveau-nyan.conf /etc/X11/xorg.conf.d
cp /etc/X11/xorg.conf.d.samples/51-newer-xorg-chromebook-kbd.conf /etc/X11/xorg.conf.d
cp /etc/X11/xorg.conf.d.samples/51-newer-xorg-old-input.conf /etc/X11/xorg.conf.d
cp /etc/X11/xorg.conf.d.samples/51-touchpad.conf /etc/X11/xorg.conf.d
# make sure the shared libraries in /opt/mesa/lib/arm-linux-gnueabihf and /opt/oldlibs get used
# via /etc/ld.so.conf.d/aaa-mesa.conf and /etc/ld.so.conf.d/aaa-oldlibs.conf
ldconfig
# restart lightdm - this will restart the current x11 session using the old stuff
systemctl restart lightdm
```
