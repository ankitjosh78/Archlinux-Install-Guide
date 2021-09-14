#!/bin/bash

echo "Hello there"
sleep 2s
echo "Setting timezone"
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
locale-gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "Enter your hostname:"
read $hostname
echo $hostname > /etc/hosts
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
echo "Enter password for root user"
passwd
echo "Installing useful packages..."
pacman --noconfirm -S vim dhcpcd sudo git cryptsetup device-mapper dhcpcd diffutils e2fsprogs inetutils jfsutils less linux linux-firmware logrotate lvm2 man-db man-pages mdadm nano netctl perl reiserfsprogs s-nail sysfsutils texinfo usbutils vi which xfsprogs noto-fonts-emoji noto-fonts ttf-joypixels ttf-jetbrains-mono 
echo "Enabling dhcpcd for automatic network connection on every boot"
systemctl enable dhcpcd
echo "We are going to make a user now."
echo "Enter username:"
read username
useradd -m $username
echo "Enter password for $username"
passwd $username
usermod -aG wheel,audio,video,optical,storage $username
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
echo "Installing bootloader"
pacman --noconfirm -S grub
grub-install --target-i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
echo "Congratulations you have succesfully installed Archlinux"


