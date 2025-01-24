#!/usr/bin/env bash

build-image()
{
    make bzImage \
        -j"${NPROC:-$(nproc)}" \
        LLVM="1" CC="ccache clang" \
        KCFLAGS="$KCFLAGS -fdiagnostics-color=auto -Werror"
}

build-ramdisk()
{
    sudo modprobe -r brd
    sudo modprobe brd brd rd_nr=1 rd_size=$((4096 * 1024))
}

boot-image()
{
    [ -b "/dev/ram0" ] && IMG_DISK="/dev/ram0"

    qemu-system-x86_64 \
        -nographic -enable-kvm -m size=4G \
        -cpu host -smp cpus=4,sockets=1,dies=1,cores=4,threads=1 \
        -machine type=q35,usb=off,dump-guest-core=off,hpet=off,accel=kvm \
        -serial mon:stdio \
        -device virtio-balloon-pci,id=balloon0,bus=pcie.0,addr=0x4 \
        -device virtio-rng-pci,rng=objrng0,id=rng0,bus=pcie.0,addr=0x1c \
        -net user,hostfwd=tcp:127.0.0.1:10022-:22 \
        -net nic,model=virtio-net-pci \
        -object rng-random,id=objrng0,filename=/dev/urandom \
        -append "console=ttyS0 root=/dev/vda earlyprintk=serial net.ifnames=0 nokaslr" \
        -gdb tcp::1234 \
        -pidfile "$XDG_RUNTIME_DIR/qemu.pid" \
        -kernel "$IMG_KERNEL" \
        -drive if=virtio,format=raw,aio=io_uring,cache=writeback,discard=on,detect-zeroes=on,file="$IMG_ROOT" \
        -drive if=virtio,format=raw,aio=io_uring,cache=writeback,discard=on,detect-zeroes=on,file="$IMG_DISK"

        # -device virtio-net,netdev=vmnic -netdev bridge,br=virbr0,id=vmnic \
}

kgdb()
{
    gdb "$IMG_VMLINUX" -ex "gef-remote --qemu-user localhost 1234"
}

