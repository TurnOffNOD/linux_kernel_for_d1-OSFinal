# OS期末大作业-14组（选做实验3）
**使用的发行版：https://d1.docs.aw-ol.com/strong/strong_4debian/ ，用的是RVBoards_D1_Debian_img_v0.6.1版本**

（下载地址：http://www.perfxlab.cn:8080/rvboards/）

**先根据https://d1.docs.aw-ol.com/study/study_4compile/， 使用上述的发行版制作启动TF卡。**


## 大作业代码架构：
+ 该repo用于使能哪吒D1开发板上的uart5串口，在linux里注册为设备`/dev/ttyS5`，步骤下面详述。
+ 在使能uart5之后，用https://github.com/TurnOffNOD/group14-osFinal-NFCapp 作为而NFC板子的驱动进行读写。

**用于使能的dts文件位于：`arch/riscv/boot/dts/sunxi/board_enable_uart5.dts`**

使用：在该repo目录下，执行下述命令制作dtbo：
```bash
./scripts/dtc/dtc -I dts -O dtb arch/riscv/boot/dts/sunxi/board_enable_uart5.dts -o enable-uart5.dtbo
```
之后的步骤：
1. 将上面制作得到的TF卡插入linux主机，（自己实验时是将TF卡+TF转SD卡卡套插入笔记本电脑的读卡器）；
2. 挂载，得到的enable-uart5.dtbo复制进入boot分区的overlay文件夹下，（实验时，在自己电脑的路径为`/run/media/<username>/D899-0644/overlay`）；
3. 修改boot分区下的`config.txt`，将`dtoverlay`一行修改为`dtoverlay=enable-uart5`；
4. unmount，将TF卡插入哪吒D1开发板启动。

此时将有了`/dev/ttyS5`，继续前往https://github.com/TurnOffNOD/group14-osFinal-NFCapp 即可。


## 下面是实验过程中的一些没有在最终结果中使用的中间探索说明，在此不作删除。
**注意：现在自己微小修改过的脚本，需要将该repo和tina的sdk放在同一个目录下，并且将tina的sdk命名为tina-sdk-d1**

## 下面是原repo带的readme说明，不做删除。
# Instructions

Note: Please update the RVBoards image to V0.5 or above

## Generate the kernel image rvboards_boot.img
1 Compile the kernel with./mk-kernel.sh and generate rvboards_img/rvboards_boot.img

	Configure the default config and board.dts
	
	1. config
	
	   1. cp config_rvboards_d1 .config
	   
	2. rvboards_dts
	
	   1. cd arch/riscv/boot/dts/sunxi/
	   
	   2. cp board.dts_rvboards_d1 board.dts
	   
2 Download the cross-compile toolchain and configure CROSS_COMPILE in mk-kernel.sh

Baidu network disk link:https://pan.baidu.com/s/1-F9YPfm_dGFTlf-rld8OEw 

Extract code:3o5v

Note:The cross-compilation toolchain is extracted from the Zhan D1 Nezha Tina SDK. The directory is as follows:

	<<tina-d1-open/lichee/brandy-2.0/tools/toolchain/riscv64-linux-x86_64-20200528.tar.xz>>
## Replace the kernel image rvboards_boot.img
```shell
 #1. Create a new Boot folder in the desktop directory
root@RVBoards:~/Desktop#  mkdir boot

 #2 mount the boot partition
root@RVBoards:~/Desktop# mount /dev/mmcblk0p4 boot/

 #3 Check if mount was successful
root@RVBoards:~/Desktop# ls boot/
'System Volume Information'   boot_debian.img   config.txt   rt-smart
 boot.img                     boot_tina.img     overlay
 
 #4. Place rvboards_boot.img in the boot directory and configure config.txt
root@RVBoards:~/Desktop/boot# vim config.txt
	## kernel=rvboards_boot.img
  
 #5. Restart to rvboards_boot.img
root@RVBoards:~/Desktop/boot# reboot

```

