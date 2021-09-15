#!/bin/bash

#Caution: Don't run this script on a functioning system.
#part1
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
echo "Enter the drive:"
read drive
cfdisk $drive
echo "Enter the Linux partition:"
read partition
mkfs.ext4 $partition
mount $partition /mnt
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

sed '1,/^#part2$/d' install_script.sh > /mnt/install_script_2.sh
chmod +x /mnt/install_script_2.sh
arch-chroot /mnt ./install_script_2.sh
exit

#part2
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
echo "We are going to install some useful packages now"
sleep 3s
pacman --noconfirm -S vim dhcpcd sudo git cryptsetup device-mapper dhcpcd diffutils e2fsprogs inetutils jfsutils less linux linux-firmware logrotate lvm2 man-db man-pages mdadm nano netctl perl reiserfsprogs s-nail sysfsutils texinfo usbutils vi which xfsprogs noto-fonts-emoji noto-fonts ttf-joypixels ttf-jetbrains-mono networkmanager 
systemctl enable dhcpcd
systemctl enable NetworkManager
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
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
rm /install_script_2.sh
echo ""
echo "Congratulations you have succesfully installed Archlinux"
echo ""
echo "You can now reboot or continue to install other things or keep using the system"

