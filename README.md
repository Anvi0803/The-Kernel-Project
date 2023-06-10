
# The Kernel Project

This project is to deeply understand and learn the working and development process of an operating system along with its kernel and boot loader




## Requirements

We need to firstly install 'nasm' to compile x86 assembly files:

```bash
  sudo apt install nasm -y
```
Also, the installation of C/C++ compiler is required in order to compile the Operating System Code:

```bash
  sudo apt install gcc g++ -y
```

We would also need make for building our project, so:

```bash
    sudo apt install make
```

Now, to test our operating system, we would be needing a Virtual Machine or an emulator. 

We'll be setting up 'QEMU' for that purpose:

```bash
    sudo apt update && sudo apt upgrade
    sudo apt install libvirt-daemon
    sudo apt install qemu-kvm qemu
    sudo apt install virt-manager virt-viewer
```
We have installed all the basic packages required for the QEMU setup

Now, Enable the libvirt-deamon by executing the following commands

```bash
    sudo systemctl enable libvirtd
    sudo systemctl start libvirtd
```


## Installation

To install the project, 

Firstly, clone the project to your local system.

In your CLI, enter: 

```bash
  git clone https://github.com/NTCC2-Amity/The-Kernel-Project.git
```
After you have successfully cloned our repository, change the current directory to the cloned repository through your CLI :

```bash
    cd The-Kernel-Project
```
Now, 

To Build the Project use:

```bash
    make build
```
As the project has been build successfully, we need to boot our files in QEMU.

As, it is going to be a 32-bit OS, we'll use the following command:

```bash
    qemu-system-i386 -fda build/boot.img
```

If the above command throws the error - "qemu-system-i386: symbol lookup error: /snap/core20/current/lib/x86_64-linux-gnu/libpthread.so.0: undefined symbol: __libc_pthread_init, version GLIBC_PRIVATE"

use the command: 

```bash 
    unset GTK_PATH
```
