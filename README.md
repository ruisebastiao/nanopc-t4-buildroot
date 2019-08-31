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

mkdir output
cd output
