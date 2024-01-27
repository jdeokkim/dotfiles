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
4. Locale: `ko_KR.UTF-8`
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
