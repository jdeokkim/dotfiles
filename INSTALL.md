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

## 기본 패키지 설치하기

```
$ sudo xbps-install -u xbps
$ sudo xbps-install base-devel eudev eudev-libudev git kitty vim xorg
```

<br />

## 콘솔 글꼴 변경하기

```
$ sudo xbps-install terminus-font
$ ls /usr/share/kbd/consolefonts
$ sudo vim /etc/rc.conf
```

```
FONT="ter-v16n"
```

<br />

## [`sdorfehs`](https://github.com/jcs/sdorfehs) WM (Window Manager) 설치하기

```
$ sudo xbps-install freetype-devel libX11-devel libXft-devel libXrandr-devel libXres-devel libXtst-devel
$ git clone https://github.com/jcs/sdorfehs && cd sdorfehs
$ make && sudo make install
```

<br />

## 한글 글꼴 설치하기

```
$ sudo xbps-query -Rs font
$ sudo xbps-install fonts-nanum-ttf fonts-roboto-ttf nerd-fonts noto-fonts-cjk
```

<br />
