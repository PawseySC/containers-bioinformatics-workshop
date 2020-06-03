---
layout: page
title: Setup
root: .
---

The main requirement for this workshop is a personal computer with a web browser and a command line shell program.  
These will allow you to follow the online materials and to login to a facility with the required software stack.

* **Nimbus Cloud @Pawsey**: if you have access, both Singularity and Docker are preinstalled in the *Ubuntu Pawsey* base image.
<!-- Test: Ubuntu 18.04 VM with 2 cores, 6 GB RAM, 40 GB disk -->

* **Zeus @Pawsey**: if you have access, Singularity can be loaded with `module load singularity`. 

* **BYO Device**: if you have a Linux box, you can install the required software yourself (might take a while):

  - Singularity : [script]({{ page.root }}/files/install-singularity.sh) \| [docs](https://sylabs.io/guides/3.5/user-guide/quick_start.html)
  - Docker : [docs (unofficial)](https://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/how-to-install-docker-on-ubuntu-18-04-lts-bionic-beaver.html)
  - Nextflow engine : [script]({{ page.root }}/files/install-nextflow.sh) \| [docs](https://www.nextflow.io/docs/latest/getstarted.html)
  - Environment modules : [script]({{ page.root }}/files/install-modules.sh) \| [docs](http://modules.sourceforge.net)

**Notes**
* Install scripts have been tested on a Ubuntu machine through a user that can run *sudo* commands without password prompts. There's no warranty they will work in your Linux box, you should consider them as templates.
* To install Singularity on a Mac or Windows machine, follow these instructions by Sylabs on [Setting up Singularity with Vagrant](https://sylabs.io/guides/3.5/admin-guide/installation.html#installation-on-windows-or-mac).
