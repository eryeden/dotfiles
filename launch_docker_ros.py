#!/usr/bin/env python3
#!coding: UTF-8

import sys
import subprocess
from enum import IntEnum, auto


class ContainerStatus(IntEnum):
    RUNNING = auto()
    EXITED = auto()
    NOT_EXIST = auto()
    
def GetContainerStatus(name):
    cmd = 'docker ps -a -f "name=' + name + '" --format "{{.Status}}"'
    res = subprocess.check_output(cmd, shell=True)
    out = res.decode('utf-8').split(' ')[0]
    contaier_status = ContainerStatus.NOT_EXIST
    if(out == 'Up'):
        contaier_status = ContainerStatus.RUNNING
    elif(out == 'Exited'):
        contaier_status = ContainerStatus.EXITED
    else:
        contaier_status = ContainerStatus.NOT_EXIST
    return contaier_status
    

def GenerateContainer(image_name, container_name, host_name):
    cmd = 'docker run -it '\
    '--user=$(id -u):$(id -g) '\
    '$(for i in $(id -G); do echo -n " --group-add "$i; done) '\
    '--env=DISPLAY=$DISPLAY '\
    '--env=QT_X11_NO_MITSHM=1 '\
    '--env=LC_ALL=C.UTF-8 '\
    '--workdir="/home/$USER" '\
    '--volume="/home/$USER:/home/$USER" '\
    '--volume="/etc/group:/etc/group:ro" '\
    '--volume="/etc/passwd:/etc/passwd:ro" '\
    '--volume="/etc/shadow:/etc/shadow:ro" '\
    '--volume="/etc/sudoers.d:/etc/sudoers.d:ro" '\
    '--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" '\
    '--runtime=nvidia '\
    '--name='
    cmd = cmd + '"' + container_name + '" ' # add container name
    cmd = cmd + ' --hostname=' + '"'+ host_name +'"'
    cmd = cmd + " " + image_name
    print(cmd)
    res = subprocess.call(cmd, shell=True)

def JoinContainer(container_name):
    cmd = 'docker exec -it ' + container_name + ' bash'
    print(cmd)
    res = subprocess.call(cmd, shell=True)

def StartContainer(container_name):
    cmd = 'docker start ' + container_name
    print(cmd)
    res = subprocess.call(cmd, shell=True)



container_name = 'kinetic_nvidia_test1'
container_hostname = 'kinetic_nvidia_test1'
iamge_name = "my_kinetic_nvidia:latest"
status = GetContainerStatus(container_name)


if(status == ContainerStatus.RUNNING):
    # コンテナがすでに動いている：execでbashの起動
    JoinContainer(container_name)
    pass
elif(status == ContainerStatus.EXITED):
    # コンテナが止まっているとき：startで起動、後にexecでbashの起動
    StartContainer(container_name)
    JoinContainer(container_name)
    pass
elif(status == ContainerStatus.NOT_EXIST):
    # コンテナがないとき：コンテナを生成、bash起動
    GenerateContainer(iamge_name, container_name, container_hostname)
    pass
else:
    pass



