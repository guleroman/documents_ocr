FROM python:3-onbuild

RUN pip3 install --upgrade pip
RUN apt-get update && yes | apt-get upgrade
RUN pip3 install tensorflow
RUN apt-get install -y protobuf-compiler python3-pil python3-lxml

RUN git clone https://github.com/tensorflow/models.git /tensorflow/models
RUN cd tensorflow/models/research/object_detection; git clone https://github.com/guleroman/documents_ocr
RUN mv tensorflow/models/research/object_detection/documents_ocr/* tensorflow/models/research/object_detection

WORKDIR /tensorflow/models/research

RUN apt-get install -y wget unzip
RUN wget -O protobuf.zip https://github.com/google/protobuf/releases/download/v3.0.0/protoc-3.0.0-linux-x86_64.zip
RUN unzip protobuf.zip 
RUN ./bin/protoc object_detection/protos/*.proto --python_out=.

RUN export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim


RUN pip3 install Cython
RUN pip3 install contextlib2  
RUN pip3 install pandas 
RUN pip3 install pillow 
RUN pip3 install opencv-contrib-python

RUN apt-get install -y libsm6 libxext6 tesseract-ocr libtesseract-dev libleptonica-dev pkg-config tesseract-ocr-rus
RUN CPPFLAGS=-I/usr/local/include pip3 install tesserocr

RUN  wget -O /tensorflow/models/research/object_detection/snils_graph/frozen_inference_graph.pb https://github.com/guleroman/documents_ocr/raw/master/snils_graph/frozen_inference_graph.pb

WORKDIR /tensorflow/models/research/object_detection

EXPOSE 2222

ENTRYPOINT ["python3", "app_2.py"]