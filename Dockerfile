FROM ubuntu:16.04


RUN apt-get update && yes | apt-get upgrade
RUN apt-get install -y git python3 python3-dev python3-pip
RUN pip3 install --upgrade pip
RUN pip3 install tensorflow
RUN mkdir tensorflow/models/research/object_detection
RUN cd tensorflow/models/research/object_detection; git clone https://github.com/guleroman/documents_ocr.git
RUN mv tensorflow/models/research/object_detection/documents_ocr/* tensorflow/models/research/object_detection

RUN pip3 install Cython
RUN pip3 install contextlib2
RUN pip3 install numpy  
RUN pip3 install pandas 
RUN pip3 install pillow 
RUN pip3 install opencv-contrib-python
RUN pip3 install flask
RUN pip3 install requests

RUN apt-get install -y libsm6 libxext6 tesseract-ocr libtesseract-dev libleptonica-dev pkg-config tesseract-ocr-rus
RUN CPPFLAGS=-I/usr/local/include pip3 install tesserocr

RUN  wget -O /tensorflow/models/research/object_detection/snils_graph/frozen_inference_graph.pb https://github.com/guleroman/documents_ocr/raw/master/snils_graph/frozen_inference_graph.pb


WORKDIR /tensorflow/models/research/object_detection

EXPOSE 2222


ENTRYPOINT ["python3", "app_2.py"]