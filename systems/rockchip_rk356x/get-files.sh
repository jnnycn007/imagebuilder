# this file is supposed to be sourced by the get-files shell script

rockchip_rk356x_release_version="6.18.34-stb-r56%2B"
rockchip_rk3566_uboot_h96max_v56_version="260610-01"
rockchip_rk3566_uboot_x96_x6_version="260610-01"

rm -f ${DOWNLOAD_DIR}/kernel-rockchip_rk356x-${2}.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/releases/download/${rockchip_rk356x_release_version}/${rockchip_rk356x_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-rockchip_rk356x-${2}.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-rockchip_rk356x-${2}.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${rockchip_rk3566_uboot_h96max_v56_version}/boot-rk3566-h96max-v56-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-rockchip_rk356x-${2}.dd
# get different u-boot versions for different rk356x rockchip devices to have them around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
cp ${DOWNLOAD_DIR}/boot-rockchip_rk356x-${2}.dd ${DOWNLOAD_DIR}/boot-extra-${1}/boot-rk3566-h96max-v56-aarch64.dd
wget -v https://github.com/hexdump0815/u-boot-misc/releases/download/${rockchip_rk3566_uboot_x96_x6_version}/boot-rk3566-x96-x6-aarch64.dd.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/boot-rk3566-x96-x6-aarch64.dd

# old stuff - to be deleted later ...
# rockchip_rk356x_u_boot_binary_version="ac8666b89e8d5787ad31c5ed22a1c51865c0f43f"
#
# rm -f ${DOWNLOAD_DIR}/boot-rockchip_rk356x-${2}.dd
# wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk356x_u_boot_binary_version}/misc.r56/u-boot/boot-x96_x6.dd.gz -O - | gunzip -c | dd bs=512 seek=1 skip=1 of=${DOWNLOAD_DIR}/boot-rockchip_rk356x-${2}.dd
#
# # get different u-boot versions for different rk33xx rockchip versions to have them around
# rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
# mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
# cp ${DOWNLOAD_DIR}/boot-rockchip_rk356x-${2}.dd ${DOWNLOAD_DIR}/boot-extra-${1}/boot-x96_x6.dd
# wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk356x_u_boot_binary_version}/misc.r56/u-boot/boot-quartz64-b.dd.gz -O - | gunzip -c | dd bs=512 seek=34 skip=34 of=${DOWNLOAD_DIR}/boot-extra-${1}/boot-quartz64-b.dd
# wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk356x_u_boot_binary_version}/misc.r56/u-boot/boot-rock3-a.dd.gz -O - | gunzip -c | dd bs=512 seek=34 skip=34 of=${DOWNLOAD_DIR}/boot-extra-${1}/boot-rock3-a.dd
# wget -v https://github.com/hexdump0815/linux-mainline-and-mali-rockchip-rk33xx-kernel/raw/${rockchip_rk356x_u_boot_binary_version}/misc.r56/u-boot/boot-rock3-c.dd.gz -O - | gunzip -c | dd bs=512 seek=34 skip=34 of=${DOWNLOAD_DIR}/boot-extra-${1}/boot-rock3-c.dd
