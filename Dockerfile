FROM gcr.io/cloud-datalab/datalab:latest
#MAINTAINER Inturiyam
RUN OPENCV_VERSION='3.4.2'
RUN apt-get update -y
RUN apt-get update 
RUN apt-get install -y --allow-unauthenticated build-essential cmake
RUN apt-get install -y --allow-unauthenticated qt5-default libvtk6-dev
RUN apt-get install -y --allow-unauthenticated zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev
RUN apt-get install -y --allow-unauthenticated libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev 
RUN apt-get install -y --allow-unauthenticated  libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev
RUN apt-get install -y --allow-unauthenticated libtbb-dev libeigen3-dev
RUN apt-get install -y --allow-unauthenticated python-dev python-tk python-numpy python3-dev python3-tk python3-numpy
RUN apt-get install -y --allow-unauthenticated doxygen
RUN apt-get install -y --allow-unauthenticated unzip wget
#RUN OPENCV_VERSION='3.4.2'
RUN wget https://github.com/opencv/opencv/archive/3.4.2.zip \
 && unzip 3.4.2.zip && rm 3.4.2.zip && mv opencv-3.4.2 OpenCV \
&& cd OpenCV && mkdir build && cd build \
&& cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON -DENABLE_PRECOMPILED_HEADERS=OFF ..\ 
&& make -j4 && make install && ldconfig
