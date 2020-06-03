---
layout: page
title: Setup
root: .
---


### Key requirement

The main requirement for this workshop is a personal computer with a web browser and a command line shell program (*Windows* users: get [MobaXterm](https://mobaxterm.mobatek.net/download-home-edition.html), [Visual Studio Code](https://code.visualstudio.com/) or PuTTY).  
These will allow you to follow the online materials and to login to a facility with the required software stack.

You might want to brush up on the fundamentals of the [Linux Shell for HPC](https://pawseysc.github.io/shell-hpc/).  

Also, the tutorial [Containers on HPC and Cloud with Singularity](https://pawseysc.github.io/singularity-containers/) is the ideal starting point prior to running this workshop.


### Optional: Pawsey users

* **Nimbus Cloud @Pawsey**: if you have access, both Singularity and Docker are preinstalled in the *Ubuntu Pawsey* base image.
<!-- Test: Ubuntu 18.04 VM with 2 cores, 6 GB RAM, 40 GB disk -->

* **Zeus @Pawsey**: if you have access, Singularity can be loaded with `module load singularity`. 


> ## Advanced: installation DIY (Do It Yourself)
> 
> If you have a Linux box, you can install the required software yourself (might take a while).
> 
> > ## Read more
> > 
> > * Required
> >   - Singularity : [script]({{ page.root }}/files/install-singularity.sh) \| [docs](https://sylabs.io/guides/3.5/user-guide/quick_start.html)
> >   - Docker : [docs (unofficial)](https://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/how-to-install-docker-on-ubuntu-18-04-lts-bionic-beaver.html)
> >   - Nextflow engine : [script]({{ page.root }}/files/install-nextflow.sh) \| [docs](https://www.nextflow.io/docs/latest/getstarted.html)
> >   - Environment modules : [script]({{ page.root }}/files/install-modules.sh) \| [docs](http://modules.sourceforge.net)
> > 
> > **Notes**
> > * Install scripts have been tested on a Ubuntu machine through a user that can run *sudo* commands without password prompts. There's no warranty they will work in your Linux box, you should consider them as templates.
> > * To install Singularity on a Mac or Windows machine, you will need to setup a Linux virtual machine, and then follow the same instructions as above.  It's not as bad as it sounds... the main two options are:
> >   - Vagrant: follow these instructions by Sylabs on [Setting up Singularity with Vagrant](https://sylabs.io/guides/3.5/admin-guide/installation.html#installation-on-windows-or-mac) (*Mac* users: DO NOT use the proposed *Singularity Desktop*, use Vagrant instead);
> >   - Multipass: follow instructions from the [Multipass Homepage](https://multipass.run).
> {: .solution}
{: .challenge}
