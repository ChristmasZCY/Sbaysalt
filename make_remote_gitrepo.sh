#!/bin/zsh
# -*- coding: utf-8 -*-
#  日期 : 2024/3/20 23:14
#  作者 : Christmas
#  邮箱 : 273519355@qq.com
#  项目 : Mbaysalt
#  版本 : python 3
#  摘要 :

useradd -m -s /bin/bash git
passwd git
su - git
mkdir -p ~/Project/Mbaysalt.git
cd ~/Project/Mbaysalt.git || exit
git init --bare
exit
