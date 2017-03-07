######################################################################################################  
# Set the starting image
  FROM ubuntu:zesty

  MAINTAINER Daniel Fischer <daniel.fischer@luke.fi>
  
######################################################################################################  
# Install the required system components
  RUN apt-get update && apt-get install -y \
        python \
        python2.7-dev \
        python-pip \
        python-numpy \
        python-matplotlib \ 
        wget \
        unzip \
     && rm -rf /var/lib/apt/lists/*  

######################################################################################################  
# Setup the folder structure  
  RUN mkdir /data
  RUN mkdir /data/fromHost     
     
# ------------
# HiSAT2 2.0.5:
# ------------
  RUN wget -qO- ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.0.5-Linux_x86_64.zip > hisat2-2.0.5-Linux_x86_64.zip
  RUN unzip hisat2-2.0.5-Linux_x86_64.zip
  RUN mv hisat2-2.0.5 /bin/
  RUN rm hisat2-2.0.5-Linux_x86_64.zip    
    
######################################################################################################   
# The the environment variables
  ENV PATH $PATH:/bin/hisat2-2.0.5/