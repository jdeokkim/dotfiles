# Void Linux 개발 환경 구축하기

## Void Linux 설치하기

> `#`은 관리자 (root) 계정, `$`는 일반 계정을 뜻하며, 외장 SSD의 위치는 `/dev/sdb`라고 가정한다.

```
void-live login: root
Password: voidlinux

# void-installer
```

<br />

1. Keyboard: `us`
2. Mirror: Asia
    - https://repo.jing.rocks/voidlinux/ (Tokyo, Japan (Tier 2))
3. Hostname: `void`
4. Locale: `en_US.UTF-8`
5. Timezone: `Asia/Seoul`
6. RootPassword: ?
7. UserAccount: ?
8. BootLoader: `none`
9. Partition: `cfdisk` (Label Type: `gpt`)
    - `/dev/sdb1` ~ Size: 256M, Type: "EFI System"
    - `/dev/sdb2` ~ Size: 4G, Type: "Linux Swap"
    - `/dev/sdb3` ~ Size: 128G, Type: "Linux Filesystem"
10. Filesystems
    - `/dev/sdb1` ~ Type: "vfat", Mount: `/boot/efi`
    - `/dev/sdb2` ~ Type: "swap", Mount: `-`
    - `/dev/sdb3` ~ Type: "ext4", Mount: `/`
11. Install

Void Linux 설치가 끝나면, 재부팅을 하지 않고 설치 프로그램을 빠져나와 터미널로 복귀한다.

<br />

## GRUB 부트로더 설치하기

```
# mount /dev/sdb3 /mnt/
# mkdir -p /mnt/boot/efi/
# mount /dev/sdb1 /mnt/boot/efi/
# xchroot /mnt /bin/bash
=> Entering chroot /mnt/
```

```
[xchroot /mnt/] # grub-install --target=x86_64-efi --efi-directory=/boot/efi \
> --bootloader-id="Void" --removable
Installing for x86_64-efi platform.
Installation finished. No error reported.
[xchroot /mnt/] # exit
```

```
# umount -R /mnt
# shutdown -r now
```

<br />

## Wi-Fi 연결하기

```
$ sudo sv up wpa_supplicant
$ ip link show
$ wpa_cli -i wlp0s20f3
```

```
wpa_cli v2.10

Copyright (c) 2004-2022, Jouni Malinen <j@w1.fi> and contributors

This software may be distributed under the terms of the BSD license.
See README for more details.

Selected interface 'wlp0s20f3'

Interactive mode

> add_network
> set_network 0 ssid "<SSID>"
> set_network 0 psk "<PASSWORD>"
> enable_network 0
> quit
```

```
$ sudo xbps-install NetworkManager
$ sudo rm /var/service/wpa_supplicant
$ sudo ln -s /etc/sv/NetworkManager /var/service/ 
```

```
$ nmcli device wifi list
$ nmcli device wifi connect "<SSID>" password "<PASSWORD>"
```

<br />

## 기본 패키지 설치하기

```
$ sudo xbps-install -u xbps
$ sudo xbps-install acpi base-devel curl dbus elogind eudev eudev-libudev \
    git kitty neofetch ripgrep scrot vim wget xorg
$ sudo rm /var/service/acpid
$ sudo ln -s /etc/sv/dbus /var/service/
$ sudo ln -s /etc/sv/elogind /var/service/
```

<br />

## 콘솔 글꼴 변경하기

```
$ sudo xbps-install terminus-font
$ ls /usr/share/kbd/consolefonts
$ sudo vim /etc/rc.conf
```

```
# Set RTC to UTC or localtime.
HARDWARECLOCK="localtime"

# Console font to load, see setfont(8).
FONT="ter-v16n"
```

<br />

## `chronyd` NTP (Network Time Protocol) 데몬 설치하기

```
$ sudo xbps-install chrony
$ sudo ln -s /etc/sv/chronyd /var/service
$ sudo reboot 
```

<br />

## [`bluetoothd`](https://github.com/bluez/bluez) 블루투스 서비스 설치하기

```
$ sudo xbps-install bluez libspa-bluetooth
$ sudo usermod -a -G bluetooth jdeokkim
$ sudo reboot 
```

<br /> 

## [`PipeWire`](https://pipewire.org) 오디오 서버 설치하기

```
$ sudo xbps-install alsa-pipewire pavucontrol pipewire
$ sudo mkdir -p /etc/alsa/conf.d/
$ sudo mkdir -p /etc/pipewire/pipewire.conf.d/
$ sudo ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf \
    /etc/alsa/conf.d/
$ sudo ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf \
     /etc/alsa/conf.d/
$ sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf \
    /etc/pipewire/pipewire.conf.d/
$ sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf \
    /etc/pipewire/pipewire.conf.d/
$ sudo usermod -aG audio jdeokkim
```

<br />

## [`sdorfehs`](https://github.com/jcs/sdorfehs) 창 관리자 설치하기

```
$ sudo xbps-install freetype-devel libX11-devel libXft-devel \
    libXrandr-devel libXres-devel libXtst-devel
$ git clone https://github.com/jcs/sdorfehs && cd sdorfehs
$ make && sudo make install
```

```
$ sudo mv /usr/local/man/man1/sdorfehs.1 /usr/local/share/man/man1/
$ sudo makewhatis /usr/local/share/man
```

```
$ wget https://nightly.link/linusg/serenityos-emoji-font/workflows/build/main/SerenityOS-Emoji.ttf.zip
$ unzip SerenityOS-Emoji.ttf.zip && sudo mv SerenityOS-Emoji.ttf /usr/share/fonts/TTF/
$ fc-cache -v
```

```
$ git clone https://github.com/nestoris/Win98SE.git
$ cd Win98SE && sudo mv SE98/ /usr/share/icons/SE98/
```

<br />

## 마우스 가속도 변경하기

```
$ xinput list | grep 'Mouse'
$ xinput list-props 9
$ xinput set-prop 9 "libinput Accel Speed" -0.55
```

<br />

## 한글 글꼴 설치하기

```
$ sudo xbps-query -Rs font
$ sudo xbps-install fonts-nanum-ttf fonts-roboto-ttf google-fonts-ttf nerd-fonts noto-fonts-cjk 
$ sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
```

```
$ wget https://github.com/Dalgona/neodgm/releases/download/v1.530/neodgm.ttf
$ sudo mkdir -p /usr/share/fonts/neodgm
$ sudo mv neodgm.ttf /usr/share/fonts/neodgm/.
$ sudo fc-cache -fv
```

<br />

## [`feh`](https://github.com/derf/feh) 이미지 뷰어로 배경 화면 설정하기

```
$ sudo xbps-install feh
$ feh --bg-fill ~/.walls/void.png
$ mkdir -p ~/Pictures
```

<br />

## [`fcitx5`](https://github.com/fcitx/fcitx5) 입력 방식 편집기 설치하기

```
$ sudo xbps-install fcitx5 fcitx5-configtool fcitx5-gtk \
    fcitx5-hangul fcitx5-qt
$ fcitx5-configtool
```

<br />

1. "Available Input Method"에서 "Hangul"을 찾아 왼쪽에 추가한다.
2. "Global Options" 탭의 "Trigger Input Method" 키를 변경한다.

<br />

## [`vim-plug`](https://github.com/junegunn/vim-plug) 플러그인 관리자 설치하기

```
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ vim ~/.vimrc
```

```
:PlugInstall
```

<br />

