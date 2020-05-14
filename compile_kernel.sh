cd /opt
wget https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz
xz -d gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz
tar -xf gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar -C gcc-aarch64
rm gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu*
cd gcc-aarch64
wget https://github.com/SuzukiHonoka/PHICOMM_N1_SHELL_API/raw/master/.config
make -j$(nproc)
