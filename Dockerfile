FROM mono:latest

RUN mkdir /build
WORKDIR /build

COPY Librarys/litjson /build/Librarys/litjson
COPY Librarys/Mono.Posix /build/Librarys/Mono.Posix
COPY Librarys/mqtt /build/Librarys/mqtt
COPY Lora-Scral /build/Lora-Scral
COPY Utils/ConnectorDataMqtt /build/Utils/ConnectorDataMqtt
COPY Utils/Utils /build/Utils/Utils
COPY Utils/Utils-IoT /build/Utils/Utils-IoT

RUN mkdir Builds
RUN msbuild /p:Configuration="Release" /p:Platform="Any CPU" /p:OutputPath="./bin/Release/" "Lora-Scral/Lora-Scral.sln"

RUN mkdir /usr/local/bin/lorascral -p
RUN cp Lora-Scral/Lora-Scral/bin/Release/*.dll /usr/local/bin/lorascral -r
RUN cp Lora-Scral/Lora-Scral/bin/Release/*.exe /usr/local/bin/lorascral -r

RUN mkdir /etc/monicascral -p
RUN cp Lora-Scral/Lora-Scral/bin/Release/config-example/* /etc/monicascral -r
RUN touch /etc/monicascral/settings.conf

WORKDIR /usr/local/bin/lorascral
