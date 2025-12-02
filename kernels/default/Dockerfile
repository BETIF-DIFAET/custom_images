FROM ubuntu:22.04

# ROOT deps
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Europe/Zurich apt-get -y -q install \
    git curl sudo wget  #ipython3.10 python3-pip 

ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda
# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

RUN conda init bash
RUN echo "conda activate base" >> ~/.bashrc

SHELL ["conda", "run", "-n", "base", "/bin/bash", "-c"]

RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main \
 && conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

RUN conda install -y python=3.11 

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

RUN python3 -m pip install -U pip setuptools wheel

#RUN curl -fsSL https://research.cs.wisc.edu/htcondor/repo/keys/HTCondor-Release.gpg.key | apt-key add - \
#    && echo  "deb [arch=amd64] https://research.cs.wisc.edu/htcondor/repo/ubuntu/8.9 focal main\ndeb-src https://research.cs.wisc.edu/htcondor/repo/ubuntu/8.9 focal main" > /etc/apt/sources.list.d/htcondor.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Europe/Zurich #apt-get install -y htcondor

RUN python3 -m pip install \
    click \
    ipython 

RUN apt-get -y install davix

RUN python3 -m pip install rucio-clients 

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "base"]
