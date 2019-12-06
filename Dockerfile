FROM mcr.microsoft.com/dotnet/core/sdk:3.0

RUN mkdir /build
WORKDIR /build

COPY Lora-Scral /build/Lora-Scral

COPY Librarys/litjson /build/Librarys/litjson
COPY Librarys/mqtt /build/Librarys/mqtt

COPY Utils/Bot-Utils /build/Utils/Bot-Utils
COPY Utils/ConnectorDataMqtt /build/Utils/ConnectorDataMqtt
COPY Utils/Utils /build/Utils/Utils
COPY Utils/Utils-IoT /build/Utils/Utils-IoT

WORKDIR /build/Lora-Scral
RUN dotnet build Lora-Scral.sln --configuration Release

RUN mkdir /usr/local/bin/lorascral -p
RUN cp Lora-Scral/bin/Release/netcoreapp3.0/*.dll /usr/local/bin/lorascral -r
RUN cp Lora-Scral/bin/Release/netcoreapp3.0/*.runtimeconfig.json /usr/local/bin/lorascral -r

WORKDIR /usr/local/bin/lorascral
RUN rm -r /build

RUN mkdir /etc/lorascral -p