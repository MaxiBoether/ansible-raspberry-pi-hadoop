# Ansible Playbook for quickly setting up Hadoop on a Raspberry Pi Cluster
## Background
This project is part of a paper (TBD). There is also a project website for it where you can find more information on its usage: https://hpi.de/rabl

## Structure of the Project
This playbook is structured in different roles that fulfill specific purposes. You can find the roles in the `roles` folder. We will give a short description of each role here. For further details, either read the playbook or refer to the project website where we explain it in more detail.

### managed_host and managed_node
These two roles are the basic setup of the system which could be used on every Debian system. This includes stuff like shell, hardening, watchdog etc.

### raspberry_compute
This role complements the managed_\* roles as it's responsible for the basic setup of each Raspberry Pi node. Thus, we are doing stuff like installing the latest version of ARM GCC and resizing the filesystem on the SD Card, but also setting up monitoring (Ganglia) as well as hostnames.

### raspberry_docker
This role is not used by default. If you want, you can apply this role to install Docker on your Pis as well.

### raspberry_master
This role is specifically applied to the master node of the cluster. In here, we are setting up the network gateway as well as monitoring.

### raspberry_node
This role is applied on all Pis (including the master node) and sets up Hadoop and the JDK. It automatically sets up a basic structure on HDFS with correct permissions on important directories.

## Usage
First of all, make sure to generate a new ssh-key-pair and place it into the root directory of this project. Furthermore, create a folder called `native` in the root and copy your Hadoop native ARM bindings into it. You can find ARM Hadoop bindings we compiled ourselves on the project website. Otherwise, just download default x86 bindings, but these will be ignored when running Hadoop.

All configuration for the setup itself is done in `config.xml`. If your ssh_key pair is not named `id_rsa` and `id_rsa.pub`, make sure to fix the name in it. Also, you can enter your personal SSH key in the `config.xml` in order to `ssh pi@node0x` without using the password. The Hadoop settings (blocksize etc.) are found in `roles/raspberry_node/defaults/main.yml` and can be overwritten. Per node settings are supplied in `hosts.yml`. If you want to use Docker as well, make sure to change `raspberry_compute` to `raspberry_docker` in the `setup.yml`.

## Credits
We acknowledge all other projects and playbooks we took parts from in the ACKNOWLEDGEMENTS_AND_LICENSES file. We again want to thank them here:

- Lukas Pirl: managed_hosts and managed_node roles
- Charles Korn: raspi-expanded-rootfs roles
- Nick Janetakis: ansible-docker role
- Matt Margolin: ansible-role-hadoop
- abhiTronix: Raspberry PI GCC Cross Compiler Toolchain
