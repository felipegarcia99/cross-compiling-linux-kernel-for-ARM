## VARIÁVEIS DE AMBIENTE ##

# exportar o compilador cruzado para o PATH:
export PATH=$PATH:/home/felipe/texasSDK/linux-devkit/sysroots/x86_64-arago-linux/usr/bin

# definir a arquitetura
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-

# definir o caminho pasta de saída
export RAIZ="/home/felipe/texasSDK/board-support/kernel_brincadeira/saida"

# definir o caminho do código-fonte
export SOURCE="/home/felipe/texasSDK/board-support/linux-4.19.38-RASCUNHO"

## INÍCIO ##

# abrir a pasta do código-fonte do kernel Linux
cd $SOURCE

# limpar compilações anteriores
make distclean

# selecionar a configuração padrão da BeagleBone Black
make tisdk_am335x-evm_defconfig

# personalizar
make menuconfig

# compilar APENAS o ELF
make -j5 zImage

# compilar device tree
make -j5 am335x-boneblack.dtb

# compilar modulos
make -j5 modules

# instalar kernel e device tree
cp arch/arm/boot/zImage arch/arm/boot/dts/am335x-boneblack.dtb $RAIZ

# instalar modulos
make INSTALL_MOD_PATH=$RAIZ modules_install
