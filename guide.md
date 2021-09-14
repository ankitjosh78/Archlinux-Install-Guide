## Check Internet via 
   - ip link
   - ping archlinux.org

## Set time
   - timedatectl set-ntp true

## Partition Disks and Formatting
   ### Type "cfdisk" (For BIOS mode) [partitioning]
   - Select "dos" as Table Type / Delete Previous Partitions
   - First Partition xGB(x:amount of ram of system) [Primary] Type: Linux Swap 
   - Second Parition (rest of the memory) [Primary] [Bootable] Type: Linux(Default)

   ### Formatting the file system 
   - mkfs.ext4 /dev/sda2(for full system)
   - mkswap /dev/sda1 (for swap)
   - swapon (for activating swap)

## Mounting Filesystem
   - mount /dev/sda2 /mnt

## Install Base System
   - pacstrap /mnt base linux linux-firmware

## Configure System
   - genfstab -U /mnt >> /mnt/etc/fstab

## Arch Chroot
   - arch-chroot /mnt
    (Now you can use pacman to install vim)

## Set Time
   - ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
   - hwclock --systohc

## Set Locale
   - locale-gen
   - Edit /etc/locale.gen and uncomment en_US.UTF-8 UTF-8 and other needed locales.

## Network Configuration
   - vim /etc/hostname (and type  hostname)
   - vim /etc/hosts
      ### Text:
        127.0.0.1 (tab) localhost
    
        ::1 (tab) localhost
        
        127.0.1.1 (tab) hostname.localdomain (tab) hostname

## Set Password
   - passwd (for the root user)

## Useful Packages to install:
   - pacman -S vim dhcpcd sudo git cryptsetup device-mapper dhcpcd diffutils e2fsprogs inetutils jfsutils less linux linux-firmware logrotate lvm2 man-db man-pages mdadm nano netctl perl reiserfsprogs s-nail sysfsutils texinfo usbutils vi which xfsprogs 

## Advanced Network Configuration
   - pacman -S dhcpcd
   - systemctl enable dhcpcd

## Adding Users and Groups
   ### Making User
   - useradd -m userName
   - passwd userName (to make password for the user)
   ### Adding to Group
   - usermod -aG wheel,audio,video,optical,storage userName
   - visudo (Uncomment line "%wheel ALL=(ALL) ALL"

## Install Bootloader(GRUB)
   - pacman -S grub
   - grub-install --target=i386-pc /dev/sda
   - grub-mkconfig -o /boot/grub/grub.cfg

## Shutdown and restart
   - shutdown now

### You should have a working archlinux terminal only install!
### If you want you can leave your system here and just use the minimal installation.
### But I'm going to install a GUI on it. I'm going to install a window manager(dwm)
### If you have other preferences such as installing another WM or DE, feel free to do so.

### (NOTE: If you want to install KDE or GNOME or XFCE, check the bottom of this guide.)

### For others, just look up some tutorials from internet or refer to the arch wiki.

## For building the GUI system (with dwm as window manager and xinit as login manager) ->
   - sudo pacman -S base-devel xf86-video-fbdev xorg xorg-xinit nitrogen picom alacritty firefox ( X server and other useful applications)
   - git clone https://aur.archlinux.org/paru-git.git
       - cd paru-git/
       - makepkg -si
   - git clone https://github.com/ankitjosh78/nvim
   - git clone https://github.com/ankitjosh78/dwm
      -  cd dwm/
      -  rm -rf autostart.sh (Remove autostart.sh as we are going to use .xinitrc . I use autostart.sh as I now use LightDM instead of .xinitrc)
      -  sudo make clean install
   - git clone https://github.com/ankitjosh78/st
      -  cd st/
      -  sudo make clean install
   - git clone https://github.com/ankitjosh78/dotfiles (copy .xinitrc and .bashrc)
   - git clone https://github.com/ankitjosh78/wallpapers
   - git clone https://github.com/ankitjosh78/dwm-bar
   - paru -S nerd-fonts-jetbrains-mono ttf-jetbrains-mono volumeicon libxft-bgra-git font-manager
   - curl -fsSL https://starship.rs/install.sh | bash (starship shell prompt)
## Start System
   - startx


## For those who want to install a DE:
### For GNOME:
   sudo pacman -S gnome
   
   sudo systemctl enable --now gdm.service

### For KDE:
   sudo pacman -S plasma kde-applications ssdm
   
   sudo systemctl enable --now sddm

### For XFCE:
   sudo pacman -S xfce4 xfce4-goodies
   
   
