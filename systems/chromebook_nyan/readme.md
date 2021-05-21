# chromebook nyan

## bootable sd card images

- https://github.com/hexdump0815/imagebuilder/releases/tag/210321-01
- https://github.com/hexdump0815/imagebuilder/releases/tag/200526-01

## tested systems - working

- acer chromebook cb5 311 - nyan big
  - there are several versions available: 2g/4g ram and hd/full hd display
  - the 4gb/full hd i have is working well
  - sometimes the initial kernel console output stays blank but xorg will start well after a while
  - for some people the 210321-01 image did not boot, but the 200526-01 one did boot, so it might be worth to try that one too
  - see also: https://github.com/hexdump0815/imagebuilder/issues/6

## untested systems

- hp chromebook 14 g3 - nyan blaze
  - never seen one of those, but at least there is a dtb for it in the mainline kernel

## generic mainline linux on arm chromebook notes

- https://github.com/hexdump0815/linux-mainline-and-mali-on-arm-chomebooks/blob/main/readme.md

## kernel build notes

- https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.cbt
- https://github.com/hexdump0815/linux-mainline-tegra-k1-kernel/blob/master/readme.cbt
  - older v5.4 mainline kernel

## u-boot build notes

- https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/blob/master/readme.cbt

## special notes

- for the nouveau mesa opengl driver a newer version of the xorg server is required
- the boot console sometimes stays dark after u-boot, but after a while xorg will start and display properly then anyway