FROM python:3.11-slim
WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    cmake \
    aria2 \
    wget \
    pv \
    jq \
    python3-dev \
    ffmpeg \
    mediainfo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/axiomatic-systems/Bento4.git && \
    cd Bento4 && \
    mkdir cmakebuild && \
    cd cmakebuild && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make && \
    make install && \
    cd / && rm -rf Bento4

RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["python3", "main.py"]

#!git clone https://github.com/axiomatic-systems/Bento4.git && cd Bento4 && apt-get -y install cmake && mkdir cmakebuild && cd cmakebuild/ && cmake -DCMAKE_BUILD_TYPE=Release .. && make && make install
