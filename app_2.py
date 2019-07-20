#!flask/bin/python
from flask import Flask, jsonify, request, send_file
from OCR_snils import recognition
#import datetime
import requests
#import pandas as pd
import  json
import uuid

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False


@app.route('/document_ocr/',methods=['POST'])
def document_ocr ():
    key = str(uuid.uuid4())
    with open('get_image' + key +'.jpg', mode="wb") as new:
        new.write(request.data)
    return jsonify(recognition('get_image' + key +'.jpg'))


if __name__ == '__main__':
    app.run(debug=False,threaded = True, host='0.0.0.0', port=2222)