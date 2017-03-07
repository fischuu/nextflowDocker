######################################################################################################  
# Set the starting image
  FROM ubuntu:zesty

  MAINTAINER Daniel Fischer <daniel.fischer@luke.fi>
  
######################################################################################################  
# Install the required system components
  RUN apt-get update && apt-get install -y \
        openjdk-8-jre \
        python \
        git \
        wget \
        unzip \
     && rm -rf /var/lib/apt/lists/*  
  
######################################################################################################  
# Setup the folder structure  
  RUN mkdir /data
  RUN mkdir /data/fromHost

###################################################################################################### 
# Install the required binaries

# ------------
# Cufflinks 2.2.1
# ------------
  RUN wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
  RUN tar -xzf cufflinks-2.2.1.Linux_x86_64.tar.gz
  RUN mv /cufflinks-2.2.1.Linux_x86_64 /bin
  RUN rm cufflinks-2.2.1.Linux_x86_64.tar.gz
 
#-------------
# FastQC 0.11.5
# ------------
  RUN wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.5.zip
  RUN unzip fastqc_v0.11.5.zip
  RUN chmod +x /FastQC/fastqc
  RUN mv /FastQC /bin/
  RUN rm fastqc_v0.11.5.zip
  
# ------------
# STAR 2.5.2b:
# ------------
  RUN wget -qO- https://github.com/alexdobin/STAR/archive/2.5.2b.tar.gz | tar -xz
  RUN mv /STAR-2.5.2b/ /bin/STAR-2.5.2b/
  
# ------------
# HiSAT2 2.0.5:
# ------------
  RUN wget -qO- ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.0.5-Linux_x86_64.zip > hisat2-2.0.5-Linux_x86_64.zip
  RUN unzip hisat2-2.0.5-Linux_x86_64.zip
  RUN mv hisat2-2.0.5 /bin/
  RUN rm hisat2-2.0.5-Linux_x86_64.zip    
  
# -----------
# StringTie 1.33
# -----------
  RUN wget -qO- http://ccb.jhu.edu/software/stringtie/dl/stringtie-1.3.3.Linux_x86_64.tar.gz  | tar -xz
  RUN mv stringtie-1.3.3.Linux_x86_64/stringtie /bin
  
######################################################################################################   
# The the environment variables
  ENV PATH $PATH:/bin/STAR-2.5.2b/bin/Linux_x86_64_static/:/bin/hisat2-2.0.5/:/bin/FastQC/:/bin/cufflinks-2.2.1.Linux_x86_64/