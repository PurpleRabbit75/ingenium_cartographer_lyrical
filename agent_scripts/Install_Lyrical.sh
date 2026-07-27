#!/bin/bash

#AB ROS Lyrical Installation Script, copied from https://docs.ros.org/en/lyrical/Installation/Ubuntu-Install-Debs.html
#AB to use ROS in a given terminal session, run source /opt/ros/lyrical/setup.bash
cwd=$(pwd)

echo "Updating apt..."
sleep 1
sudo apt update-y && sudo apt upgrade -y && sudo apt autoremove -y

echo "Installing universe repository..."
sleep 1
sudo apt install -y software-properties-common
sudo add-apt-repository universe

echo "Configuring system..."
sleep 1
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

echo "ROS2 Lyrical installation complete."
sleep 1

cd $cwd