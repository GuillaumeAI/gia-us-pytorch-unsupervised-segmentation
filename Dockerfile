FROM ubuntu

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y python3 && ln -sf /usr/bin/python3 /usr/bin/python
RUN apt-get install -y curl
RUN apt-get install -y emacs

# Adding wget and bzip2
RUN apt-get install -y wget bzip2

# Add sudo
RUN apt-get -y install sudo

# Add user ubuntu with no password, add to sudo group
#@urir http://www.science.smith.edu/dftwiki/index.php/Tutorial:_Docker_Anaconda_Python_--_4
RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ubuntu
WORKDIR /home/ubuntu/
RUN chmod a+rwx /home/ubuntu/
#RUN echo `pwd`

###################################### END OF REALLY BASIC STUFF #############################

# Anacronda prereq
USER root
RUN apt-get install -y libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
USER ubuntu
RUN curl -O https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh 
RUN bash Anaconda3-2020.07-Linux-x86_64.sh -b
RUN rm Anaconda3-2020.07-Linux-x86_64.sh

# Set path to conda
#ENV PATH /root/anaconda3/bin:$PATH
ENV PATH /home/ubuntu/anaconda3/bin:$PATH


# Updating Anaconda packages
RUN conda update conda
RUN conda update anaconda
RUN conda update --all


# Configuring access to Jupyter
RUN mkdir /home/ubuntu/notebooks
RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /home/ubuntu/.jupyter/jupyter_notebook_config.py

# Jupyter listens port: 8888
EXPOSE 8888


# Run Jupytewr notebook as Docker main process
#@stcgoal Maybe useful later
#CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/home/ubuntu/notebooks", "--ip='*'", "--port=8888", "--no-browser"]


####################### Part to make US works, above can be considered as a base for AI systems#########
USER root
RUN conda config --set auto_activate_base false
RUN conda install pytorch torchvision cpuonly -c pytorch