#
# Last Updete: 2022/09/16
#
# Author: Yoshihiko Hara
#
# Overview:
#   Create a container containing development environment of pico-mruby (mruby for Raspberry Pi Pico).
#

# Specify the image (Ubuntu 22.04) to be the base of the container.
From ubuntu:22.04

# Specify working directory (/root).
WORKDIR /root

# Update applications and others.
RUN apt -y update
RUN apt -y upgrade

# Install working tools (vim, wget, curl, git, python3).
# Note: Ubuntu:22.04 container images do not have Python3 installed by default.
RUN apt -y install vim wget curl git python3

# Install build tools.
RUN apt -y install cmake build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib rake

# Get "pico-mruby" source code & Build.
RUN git clone https://github.com/k-mana/pico-mruby.git --recursive
WORKDIR /root/pico-mruby
RUN mkdir build
WORKDIR /root/pico-mruby/build
RUN cmake ..
RUN cmake --build .

# Specify the locale.
RUN apt -y install locales
RUN echo "ja_JP UTF-8" > /etc/locale.gen
RUN locale-gen

