#!/bin/bash

python3 -c "import cv2; print(cv2.__version__)" && echo "OpenCV2 installed " || echo "FAILED TO INSTALL OPEN CV2"
