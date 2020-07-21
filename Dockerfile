FROM ubuntu:18.04

MAINTAINER Yizheng Zhang<zhangyizheng1996@outlook.com>

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get install -y supervisor \
		openssh-server vim \
		xfce4 xfce4-goodies \
		x11vnc xvfb \
		firefox \
		git \
		pwgen \
	&& apt-get autoclean \
	&& apt-get autoremove \
	&& rm -rf /var/lib/apt/lists/*

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
	&& apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
	&& apt update

WORKDIR /root

RUN apt-get install -y ros-melodic-desktop-full python-rosdep python-rosinstall \
	&& apt-get install -y ros-melodic-apriltag-ros \
	&& apt-get install -y ros-melodic-moveit \
	&& apt-get install -y ros-melodic-moveit-visual-tools \
	&& apt-get install -y ros-melodic-fetch* \
	&& apt-get install -y ros-melodic-cartographer-ros \
	&& apt-get install -y ros-melodic-jackal* \
	&& apt-get install -y ros-melodic-trac-ik-kinematics-plugin \
	&& apt-get install -y ros-melodic-camera-calibration \
	&& apt-get install -y ros-melodic-visp-hand2eye-calibration \
	&& apt-get install -y ros-melodic-velodyne-pointcloud \
	&& apt-get install -y ros-melodic-pointcloud-to-laserscan \
	&& apt-get install -y ros-melodic-pointgrey-camera-description \
	&& apt-get install -y ros-melodic-flexbe-behavior-engine \
	&& apt-get install -y ros-melodic-trac-ik \
	&& apt-get install -y ros-melodic-realsense2-description \
	&& apt-get install -y ros-melodic-effort-controllers \
	&& apt-get install -y ros-melodic-realsense2-description \
	&& apt-get install -y pcl-tools \
	&& apt-get autoclean \
	&& apt-get autoremove \
	&& rm -rf /var/lib/apt/lists/*

RUN /bin/bash -c "echo 'source /opt/ros/melodic/setup.bash' >> ~/.bashrc"

RUN git clone --depth=1 https://github.com/osrf/gazebo_models.git ./.gazebo/models/

ADD startup.sh ./
ADD supervisord.conf ./

EXPOSE 5900
EXPOSE 22

ENTRYPOINT ["./startup.sh"]
