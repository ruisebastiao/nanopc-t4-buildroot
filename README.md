# NanoPC T4 (rockchip rk3399) buildroot external tree

# Initial setup

Clone buildroot:

```
mkdir nanopct4
cd nanopct4
git clone https://github.com/buildroot/buildroot.git

git clone https://github.com/ruisebastiao/nanopc-t4-buildroot.git

```

Install dependencies :
```
sudo apt-get install -y build-essential gcc g++ autoconf automake libtool bison flex gettext
sudo apt-get install -y patch texinfo wget git gawk curl lzma bc quilt
```

# Make

```
mkdir output
cd output
make -C "../buildroot" O="$(pwd)" BR2_EXTERNAL="$(pwd)"/../nanopc-t4-buildroot/ nanopct4_defconfig

```

# Output
```
images/sd-fuse-rk3399/buildroot -> all images for use with upgrade_tool
images/sd-fuse-rk3399/out -> images to flash in sdcard: rk3399-eflasher-* for flashing emmc / rk3399-sd-buildroot-* for boot from sdcard
```

