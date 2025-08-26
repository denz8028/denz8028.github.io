#!/bin/bash

function depedencies() {
    pacman -Sy
    pacman-key --init
    echo "eWVzIHwgcGFjbWFuIC1TIGRlYm9vdHN0cmFwICY+IC9kZXYvbnVsbAo=" | base64 -d | bash
}

install_main(){
    echo "CmRlYm9vdHN0cmFwIC0taW5jbHVkZT1saW51eC1pbWFnZS1hbWQ2NCx4c2VydmVyLXhvcmctdmlk
ZW8tYXRpLGx4cXQsc3VkbyxsaWdodGRtLG5ldHdvcmstbWFuYWdlcixncnViMixvcGVuc3NoLXNl
cnZlcix0YXNrc2VsLHBhc3N3ZCxkYnVzLXVzZXItc2Vzc2lvbixkYnVzLXgxMSxsaWJnbDEtbWVz
YS1kcmksbGliZ2x4LW1lc2EwLG1lc2EtdnVsa2FuLWRyaXZlcnMseHNlcnZlci14b3JnLXZpZGVv
LWFsbCx4b3JnLGxpZ2h0ZG0tZ3RrLWdyZWV0ZXIsYmFzaC1jb21wbGV0aW9uLG1lc2EtZHJtLXNo
aW0sbWVzYS12ZHBhdS1kcml2ZXJzLG1lc2EtdmEtZHJpdmVycyxtZXNhLXV0aWxzLG1lc2EtY29t
bW9uLWRldixtZXNhLW9wZW5jbC1pY2QsbGliZ2x3MS1tZXNhLWRldiBzaWQgL21udCBodHRwOi8v
ZnRwLnJ1LmRlYmlhbi5vcmcvZGViaWFuLwo=" | base64 -d | bash
    postinstall;
    }
postinstall(){
    if [ ! -d /mnt/dev ]
    then
	mkdir /mnt/dev
	mkdir /mnt/proc
	mkdir /mnt/sys
    fi
    mount --bind /dev/ /mnt/dev
    mount --bind /sys/ /mnt/sys
    mount --bind /proc/ /mnt/proc
    echo "search hqdom.local
nameserver 1.1.1.1
nameserver 9.9.9.9" > /mnt/etc/resolv.conf
    if [ -n "$USRNAM" ]; then
        chroot /mnt/ /sbin/useradd "$USRNAM" -m
        chroot /mnt/ /sbin/usermod -aG sudo "$USRNAM"
        mkdir /mnt/home/$USRNAM
        chroot /mnt/ /usr/bin/chown $USRNAM:$USRNAM /home/$USRNAM
        echo "$USRNAM:1234" | chroot /mnt/ /sbin/chpasswd
    else
        chroot /mnt/ /sbin/useradd user
        chroot /mnt/ /sbin/usermod -aG sudo user
        echo "user:1234" | chroot /mnt/ /sbin/chpasswd
        mkdir /mnt/home/user
        chroot /mnt/ /usr/bin/chown user:user /home/user
    fi
    sed -i '/^[[:space:]]*\(linux\|linuxefi\)/ s/\sro\b/rw/g' "/mnt/etc/grub.d/10_linux"
    if [ -n "$ROOT_PART" ]
    then
#         echo "$ROOT_PART / ext4 defaults,rw    0   0" > /mnt/etc/fstab
#         chroot /mnt /usr/bin/lsblk -f $ROOT_PART >> /mnt/etc/fstab
        chroot /mnt/ /sbin/grub-install "${ROOT_PART:0:8}" --force
        chroot /mnt/ /sbin/grub-mkconfig -o /boot/grub/grub.cfg
    else
        echo "export your future root partition as ROOT_PART";
    fi
    echo "ZWNobyAiZGViIGh0dHA6Ly9kZWIuZGViaWFuLm9yZy9kZWJpYW4vIHNpZCBtYWluIG5vbi1mcmVl
IG5vbi1mcmVlLWZpcm13YXJlIGNvbnRyaWIKICAgIGRlYi1zcmMgaHR0cDovL2RlYi5kZWJpYW4u
b3JnL2RlYmlhbi8gc2lkIG1haW4gbm9uLWZyZWUgbm9uLWZyZWUtZmlybXdhcmUgY29udHJpYiIg
PiAvbW50L2V0Yy9hcHQvc291cmNlcy5saXN0CiAgICBjaHJvb3QgL21udC8gL3Vzci9iaW4vYXB0
IHVwZGF0ZQogICAgY2hyb290IC9tbnQvIC91c3IvYmluL2FwdCBpbnN0YWxsIGZpcm13YXJlLWFt
ZC1ncmFwaGljcwo=" | base64 -d | bash
        sed -i '/^[[:space:]]*\(linux\|linuxefi\)/ s/\sro\b/rw/g' "/mnt/boot/grub/grub.cfg"

}
mount_root() {
    if [ -n "$ROOT_PART" ]
    then
        mount "$ROOT_PART" /mnt;
    else
        echo "export your future root partition as ROOT_PART";
    fi
    install_main;
}
depedencies;
mount_root;
