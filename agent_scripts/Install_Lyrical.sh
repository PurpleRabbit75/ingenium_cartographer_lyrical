#!/bin/bash

#AB ROS Lyrical Installation Script, copied from https://docs.ros.org/en/lyrical/Installation/Ubuntu-Install-Debs.html
#AB to use ROS in a given terminal session, run source /opt/ros/lyrical/setup.bash
cwd=$(pwd)

echo "Updating apt..."
sleep 1
sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y

echo "Adding universe repository..."
sudo apt install software-properties-common
sudo add-apt-repository universe

sudo apt update && sudo apt install curl -y
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F'"' '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
sudo dpkg -i /tmp/ros2-apt-source.deb


echo "Updating apt a second time..."
sleep 1
sudo apt update -y && sudo apt upgrade -y

echo "Installing ros-lyrical-desktop..."
sleep 1
sudo apt install -y ros-lyrical-desktop

echo "Installing rosbag2..."
sleep 1
sudo apt-get install -y ros-lyrical-rosbag2 &
echo "Installing colcon..."
sleep 1
sudo apt install -y colcon & #AB A build tool for ROS2


#---------------------------------------------INSTALL HARDWARE DRIVERS---------------------------------------------


echo -e "$LIME Updating and upgrading apt...$NC "
sudo apt update && sudo apt upgrade -y
sleep 1

#AB We install these here and not above with the other apt installs because they require ROS Jazzy to be installed first
echo -e "$LIME Installing hardware drivers...$NC "
# TODO: Fix the names of the executables in launch.py files if they've changed
sudo apt install ros-lyrical-velodyne-driver -y #AB Install the Velodyne driver. It's in a stack hosted (I believe) on the ROS website.
sudo apt install ros-lyrical-microstrain-inertial-driver -y #AB Install the IMU driver. These drivers are now maintained as part of the built-in ROS package manager! 






echo "ROS2 Lyrical installation complete."
sleep 1

cd $cwd