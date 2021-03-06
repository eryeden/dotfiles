export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# export PATH="$PYENV_ROOT/versions/anaconda3-5.1.0/bin:$PATH"
# FOR CUDA
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

export LANG=ja_JP.UTF-8

# FOR ROS config load on docker env
case $HOSTNAME in
    (ery-Y2)
	source /opt/ros/melodic/setup.bash;
	alias terminatorROS="terminator --profile=docker-ros";;
    (kinetic_nvidia_test1) source /opt/ros/kinetic/setup.bash;;
esac

# FOR VULKAN
source ~/vulkan/1.1.85.0/setup-env.sh

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '

