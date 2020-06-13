---
title: "Session 3: building containers"
teaching: 20
exercises: 40
questions:
objectives:
---


### Goals

In this session, we're going to build together three simple container images.

In particular we'll cover:
* one RStudio image;
* one Conda image;
* one image where we're building the software ourselves.

As we've seen in the dedicated webinar, here the key tool is not Singularity but Docker, due to the higher compatibility and overwhelming popularity of its container image format.  
We're going to touch on relevant aspects of writing a Dockerfile:
* choosing an appropriate base image;
* using `RUN` to execute commands;
* using `ENV` to define environment variables;
* other useful commands;
* best practices.

Then, we're going to explore the typical steps that are required in the creation of a container image:
* building an image with `docker build`;
* testing and debugging it with `docker run`;
* sharing it on a public registry with `docker push`;
* converting it for usage with Singularity, with `singularity pull docker-daemon:`.

To brush up on building container images with Docker, you can refer to the webinar episode [Building images with Docker](https://pawseysc.github.io/singularity-containers/22-build-docker/index.html).

Writing a Dockerfile for a container is an art, which you can refine over time with practice.  
We don't mean to be exhaustive in this session; instead, we hope to provide you with the basic and most common commands, as well as some good practices.


### GUIDED - Let's have a look at the Dockerfile for R Tidyverse

Picking an appropriate base image is an important step in writing a Dockerfile.  A suitable base image can save us a lot of time, in providing pre-installed tools we need, provided it is an image we can trust in terms of quality and functionality.

Our first exercise in writing a Dockerfile is around an R package.  The [Rocker project](https://www.rocker-project.org) provides good quality images for R and RStudio.  Here we're going to use the [Tidyverse image](https://hub.docker.com/r/rocker/tidyverse), which includes R, RStudio and also the [Tidyverse](https://www.tidyverse.org) collection of data science packages.  

Let's have a look at its [Dockerfile](https://github.com/rocker-org/rocker-versioned/blob/master/tidyverse/3.6.1.Dockerfile):

```
FROM rocker/rstudio:3.6.1

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  libxml2-dev \
  libcairo2-dev \
  libsqlite3-dev \
  libmariadbd-dev \
  libmariadb-client-lgpl-dev \
  libpq-dev \
  libssh2-1-dev \
  unixodbc-dev \
  libsasl2-dev \
  && install2.r --error \
    --deps TRUE \
    tidyverse \
    dplyr \
    devtools \
    formatR \
    remotes \
    selectr \
    caTools \
    BiocManager
```
{: .source}

Let's refresh some essential key instructions in Dockerfiles.


> ## How do we specify the base image in a Dockerfile?
> 
> Can you identify the line with the base image?  What is the Docker instruction to declare it?
> 
> > ## Solution
> > 
> > The line is: 
> > 
> > ```
> > FROM rocker/rstudio:3.6.1
> > ```
> > {: .source}
> > 
> > The Docker instruction to specify the base image is `FROM`.
> > 
> > Note how the base image is not a simple Linux OS image such as Ubuntu or Centos.  Instead, it's another image by Rocker, `rocker/rstudio:3.6.1`.  
> > In turn, if we had a look at the Dockerfile for this latter image, we'd find it's based on `rocker/r-ver:3.6.1`, *i.e.* the plain *R* image by Rocker.  This one is based on the Debian OS image `debian:stretch`.  
> > This shows how it is possible to build complex containers in steps over multiple builds, by making use of increasingly more specialised images.
> {: .solution}
{: .challenge}


> ## How do we run commands in a Dockerfile?
> 
> Can you tell what is the Docker instruction to run bash shell commands in a Dockerfile?
> 
> > ## Solution
> > 
> > The Docker instruction to execute commands is `RUN`.  
> > 
> > Here, the Debian/Ubuntu package manager `apt` is used to install a set of prerequisites for Tidyverse.  
> > Then, the R utility `install2.r` (from the package *littler*) is used to install `tidyverse` and other packages, including `BiocManager` (the installer for [BioConductor](https://bioconductor.org) packages).  
> > Note how backslashes `\` followed by newlines are used to improve the readability of the bash code.
> > 
> > If you were installing Tidyverse without containers, these could be the very same commands to execute inside a Linux shell to get the job done.  The only difference in this Dockerfile is the use of the Docker syntax `RUN`.
> {: .solution}
{: .challenge}


### ROOM - Write an R Dockerfile

Now it's your turn!

First, cd into the appropriate directory:

```
$ cd /data/containers-bioinformatics-workshop
$ export WORK=$(pwd)
$ cd exercises/build/r-ggtree
```
{: .bash}

Now you're going to write a little Dockerfile for the R package `ggtree`.  The end result will actually be the RStudio image that is used in the session on graphical applications.


> ## Start writing the Dockerfile
> 
> Create a blank file called `Dockerfile`, and as first thing write a line that specifies the base image to be `rocker/tidyverse:3.6.1`, *i.e.* the image whose Dockerfile we have just commented on.
> 
> > ## Solution
> > 
> > ```
> > FROM rocker/tidyverse:3.6.1
> > ```
> > {: .source}
> {: .solution}
{: .challenge}


> ## A non-container question
> 
> The package `ggtree` is part of the BioConductor project.  So, from inside an R console you could install it by using the command `BiocManager::install("ggtree")`.  However, here you need to execute this command from the bash shell.
> 
> If you are an R user, do you know how you can execute the R command above from the shell?  No worries, just have a look at the solution if you don't.
> 
> > ## Solution
> > 
> > ```
> > R -e 'BiocManager::install("ggtree")'
> > ```
> > {: .source}
> {: .solution}
{: .challenge}


> ## Install an R package in the Dockerfile
> 
> You're almost there... now just embed the shell command above in your Dockerfile, by using the appropriate Docker instruction.
> 
> > ## Solution
> > 
> > ```
> > FROM rocker/tidyverse:3.6.1
> > 
> > RUN R -e 'BiocManager::install("ggtree")'
> > ```
> > {: .source}
> > 
> > That's it!  You've written a simple Dockerfile to install an R package on top of an R base image.
> > 
> > Very often (albeit not always) preparing Dockerfiles for R images looks as simple as this.  Other times, you will also need to install documented pre-requisites as in the Tidyverse example above.  And of course things can at times get more complicated than this.
> {: .solution}
{: .challenge}


> ## Build the image!
> 
> Now it's the time for building.  
> Use the appropriate `docker` syntax in the shell, to build an image called `ggtree:2.0.4`, assuming you're running from the directory where the Dockerfile is. 
> 
> > ## Solution
> > 
> > ```
> > $ sudo docker build -t ggtree:2.0.4 .
> > ```
> > {: .bash}
> > 
> > It will only take a couple of minutes to build, as most required R packages are already provided by the base Tidyverse image! 
> > 
> > Note how here we gave you the information about the package version; normally you would be able to find it out yourself after the first build, by inspecting the R installation in the container.
> {: .solution}
{: .challenge}


### ROOM - Write a Conda Dockerfile

In this exercise you're going to use the *Conda* package manager to install a popular bioinformatics tool, *samtools*.  
The [Anaconda](https://www.anaconda.com) developers provide a good base image to this end, namely the [miniconda3](https://hub.docker.com/r/continuumio/miniconda3) base image.

First thing, have a look at the [Dockerfile](https://github.com/ContinuumIO/docker-images/blob/master/miniconda3/debian/Dockerfile) for the *miniconda* image; you'll learn something more on practices in writing Dockerfiles:

```
FROM debian:buster-slim

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion && \
    apt-get clean

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

CMD [ "/bin/bash" ]
```
{: .source}

Similar to the *Tidyverse* Dockerfile above, there's the `FROM` specification of the base image.  

Then, two `RUN` instructions are used to execute shell commands to install packages and edit config files.  
Here, the first `RUN` is about Linux dependencies (installed through `apt`), whereas the second `RUN` installs *miniconda*.

This Dockerfile also uses additional Docker instructions.  

`ENV` is used to set environment variables both for build time and (crucially) for run time.  
For instance, the `PATH` to executables is updated to include the directory with the package-specific applications (`conda` in this case).  This is extremely common in Dockerfiles, and in software installations in general.

Finally, the instruction `CMD [ "/bin/bash" ]` specifies a default command for the image, in this case the bash shell.


> ## Some `RUN` best practices
> 
> Note how multiple shell commands are grouped into a single `RUN` execution by using the Linux syntax `&&`; it instructs the shell (or Docker here) to execute the following command only if the previous one has ended successfully (with no error).  
> Grouping commands into single `RUN`s is a good practice when building Docker images, as it reduces the number of image caching *layers*, and thus the total size of the image.  To be most effective, you would group together commands that relate to the same component of the installation, *e.g.* all *miniconda*-related commands.
> 
> Also note another best practice to reduce the size of the final image: cleaning up the installation process.  
> In this specific case, this is achieved with `apt-get clean` for the Linux `apt` installation, and with the following sequence of commands for `conda` (see also Dockerfile above):
> 
> ```
>     find /opt/conda/ -follow -type f -name '*.a' -delete && \
>     find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
>     /opt/conda/bin/conda clean -afy
> ```
> {: .source}
{: .callout}


> ## Some `ENV` best practices
> 
> Note the definition of the variables `LANG` and `LC_ALL`.  These variables are used to specify the language localisation, or *locale*, to the value *C.UTF-8* in this case.  
> The *locale* specification impacts text rendering, time/date formats, monetary formats, and language-specific characters.  Leaving this undefined can result, for some programs, in warnings or in characters being displayed inappropriately.  On the other end, setting the *locale* will avoid these issues, and should be considered as a best practice to enforce in any Dockerfile.
> 
> Talking of useful variable definitions, this is a good one, too:
> 
> ```
> ENV DEBIAN_FRONTEND="noninteractive"
> ```
> {: .source} 
> 
> Dockerfile installations are non-interactive by nature, *i.e.* no installer can ask you questions during the process.  This variable tells the shell you are not able to interact, so that no questions will be asked and default values will be picked instead.
{: .callout}


> ## Use Conda in a Dockerfile
> 
> Cd into the appropriate directory:
> 
> ```
> $ cd ../conda-samtools
> ```
> {: .bash}
> 
> Now, let's use `continuumio/miniconda3:4.8.2` as the base image for a Dockerfile that installs *samtools*.  
> 
> Samtools can be installed with Conda through the channel *bioconda*, so the shell syntax would be (`-y` is to confirm prompts):
> 
> ```
> conda install -y -c bioconda samtools
> ```
> {: .bash}
> 
> With this information, write the Dockerfile to install samtools using Conda.
> 
> > ## Solution
> > 
> > ```
> > FROM continuumio/miniconda3:4.8.2
> > 
> > RUN conda install -y -c bioconda samtools
> > ```
> > {: .source}
> > 
> > Similar to the case of R, Dockerfiles often turn out to be quite compact when using a `conda` base image.  Things are not always this easy, as for instance package version conflicts are common with Conda;  additional command lines might be required to work around them, or you might even need to install packages entirely manually.
> {: .solution}
{: .challenge}


> ## Build the image!
> 
> Similar to the previous exercise, what is the appropriate `docker` shell command to build an image called `samtools-conda:1.9`? (again we're providing version information to you)
> 
> > ## Solution
> > 
> > ```
> > $ sudo docker build -t samtools-conda:1.9 .
> > ```
> > {: .bash}
> > 
> > The build should only take a couple of minutes.
> {: .solution}
{: .challenge}


### ROOM - Write a Dockerfile to build a tool







## A useful Docker instruction

The `ARG` instruction can be used to define variables in the Dockerfile, that only exist within the build process.  This can be especially useful to specify package versions in a more general and flexible way.

For instance, you could define a variable for the samtools version:

```
ARG SAM_VER="1.9"
```
{: .source}

And then, in the `conda install` command, substitute the version `1.9` with `$SAM_VER`.







### ROOM - Feeder questions



### GUIDED - Share and convert the image

### GUIDED - Best practices
