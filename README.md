# OpenCV on Google Cloud Datalab
# opencvdatalab
# Why this Dockerfile?

I spent a lot of time struggling to get OpenCV with Datalab. While there are many Google links which say just do 'pip install opencv-python', in practice it doesn't work. There is one or other dependency which is always missing. I haven't still fully figured out what all OpenCV requires to get it working. 

I also tried Google's suggestion on Extending the Datalab as described in the below links: 
https://github.com/googledatalab/datalab/wiki/Getting-Started
https://github.com/googledatalab/datalab/tree/master/containers/datalab

In the above documentation, I really couldn't figure out:
a. where is the $REPO that they are referring to? 
b. My requirement wasn't getting fulfilled by just doing a pip install opencv-python anyways 

(I did consider modifying run.sh - but it was getting too complex and time-consuming. Another option I wanted to try was modifying the startup script attached to the VM. Will experiment some other time !)  

# About this Dockerfile

OpenCV and Datalab in themselves are very powerful. This is an attempt to create a unified Dockerfile which you can use to build an image which has Datalab has base and OpenCV (version 4.0.0) baked on top of it. 

The OpenCV installation code is based on code published at https://github.com/milq/milq/blob/master/scripts/bash/install-opencv.sh and has been adapted to Dockerfile format.   

# What next after building the Image?

After building your image from your Google Cloud VM, follow the steps outlined here (https://cloud.google.com/container-registry/docs/quickstart#add_the_image_to) to publish the image to Google Container Registry. 

Important Note: Apparently for you to be able to push the image to GCR, the VM need 'Storage Write' access. So after building the image, stop the VM on which you were building the image, edit the VM -> Go to 'Access Scopes' -> Use the option 'Set access for each API' -> 'Enable Full Access' or 'Read Write' access as you wish. 

After your push your image to GCR, go to Container Registry -> Settings page on GCP Console, in Security settings make the Container Registry host "Public". (Note that if it is set to 'Private' your Docker pull to create the Datalab VM will not work.)	

# Creating a Datalab VM with your image

To create your Datalab VM with your image, you need to run from Cloud Shell:
$ datalab create [--image-name IMAGE_NAME] [--zone ZONE] NAME

You can then get along using Datalab in your regular way.

Note: The first time Datalab creation from the GCR image seems to take a while. So if the shell seems struck at 'Waiting for Datalab to be available on 8081' message, just wait for a while. It is a one-time delay.

# Optional step
In the rare event Datalab (Jupyter) does not discover your OpenCV, run the below command, opencv-python gets properly installed. In my tests of this build, this step is not necessary. Still in case you hit an issue, please try the below step.

!/usr/local/envs/py3env/bin/python -m pip install opencv-python

After this go ahead with usual Python programming. 
import cv2 as cv 

# Add-on of Cloud Storage API package
Often while working with datalab I found the need to read/write from Google Cloud Storage. So have baked in those as well into the build. Just reduces number of imports you have to do. 
