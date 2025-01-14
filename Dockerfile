FROM python:3.6

# --------------------------------------------------------------------------------------------
# Install Cytomine python client
RUN git clone https://github.com/cytomine-uliege/Cytomine-python-client.git
RUN cd /Cytomine-python-client && git checkout tags/v2.2.0 && pip install .
RUN rm -r /Cytomine-python-client

# --------------------------------------------------------------------------------------------
# Metric for TreTrc is DIADEM.jar so it needs java
# Install Java
RUN apt-get update && apt-get install openjdk-8-jdk -y && apt-get clean

# --------------------------------------------------------------------------------------------
# Install Neubias-W5-Utilities (annotation exporter, compute metrics, helpers,...)
RUN git clone https://github.com/Neubias-WG5/neubiaswg5-utilities.git && \
        cd /neubiaswg5-utilities/ && git checkout tags/v0.6.7 && pip install .

# Get DiademMetric.jar and JSAP-2.1.jar files to compute DIADEM metric
RUN chmod +x /neubiaswg5-utilities/bin/*
RUN cp /neubiaswg5-utilities/bin/* /usr/bin/

RUN rm -r /neubiaswg5-utilities

# --------------------------------------------------------------------------------------------
# install required packages and download vaa3d
RUN wget https://github.com/Vaa3D/release/releases/download/v3.458/Vaa3D_CentOS_64bit_v3.458.tar.gz --directory-prefix=/
RUN tar -xvzf Vaa3D_CentOS_64bit_v3.458.tar.gz
RUN apt-get update
RUN apt-get install -y \
        libqt4-svg \
        libqt4-opengl \
        libqt4-network \
        libglu1-mesa
RUN apt-get install -y curl xvfb libx11-dev libxtst-dev libxrender-dev

# --------------------------------------------------------------------------------------------
# Install scripts and models
ADD wrapper.py /app/wrapper.py
ADD workflow.py /app/workflow.py
ADD swc_to_tiff_stack.py /app/swc_to_tiff_stack.py
ADD descriptor.json /app/descriptor.json

ENTRYPOINT ["python", "/app/wrapper.py"]


