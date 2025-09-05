# this file is supposed to be sourced by the get-files shell script

chromebook_veyron_release_version="6.12.42-stb-cbr%2B"
chromebook_veyron_jerry_uboot_version="v2017.09-cbr"
chromebook_veyron_speedy_uboot_version="v2021.01-cbr"
chromebook_veyron_minnie_uboot_version="v2021.01-cbr"
chromebook_veyron_mickey_uboot_version="v2021.01-cbr"

rm -f ${DOWNLOAD_DIR}/kernel-chromebook_veyron-armv7l.tar.gz
wget -v https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/releases/download/${chromebook_veyron_release_version}/${chromebook_veyron_release_version}.tar.gz -O ${DOWNLOAD_DIR}/kernel-chromebook_veyron-armv7l.tar.gz

rm -f ${DOWNLOAD_DIR}/boot-chromebook_veyron-armv7l.dd
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_veyron_jerry_uboot_version}/uboot.kpart.cbr.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-chromebook_veyron-armv7l.dd

# get different u-boot versions for different veyron versions to have them around
rm -rf ${DOWNLOAD_DIR}/boot-extra-${1}
mkdir -p ${DOWNLOAD_DIR}/boot-extra-${1}
cp ${DOWNLOAD_DIR}/boot-chromebook_veyron-armv7l.dd ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbr-jerry
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_veyron_speedy_uboot_version}/uboot.kpart.cbr-speedy.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbr-speedy
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_veyron_minnie_uboot_version}/uboot.kpart.cbr-minnie.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbr-minnie
wget -v https://github.com/hexdump0815/u-boot-chainloading-for-arm-chromebooks/releases/download/${chromebook_veyron_mickey_uboot_version}/uboot.kpart.cbr-mickey.gz -O - | gunzip -c > ${DOWNLOAD_DIR}/boot-extra-${1}/uboot.kpart.cbr-mickey
