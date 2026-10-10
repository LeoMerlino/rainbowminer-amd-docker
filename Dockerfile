FROM rocm/dev-ubuntu-24.04:latest
RUN apt update
RUN apt install -y unzip curl libicu74 pciutils xz-utils
RUN curl -s https://api.github.com/repos/RainbowMiner/RainbowMiner/releases/latest | grep -o 'https://[^"]*RainbowMiner.*linux.zip' | xargs curl -o tmp.zip -L
RUN mkdir /RainbowMiner
RUN unzip tmp.zip -d /RainbowMiner
RUN rm tmp.zip
RUN bash /RainbowMiner/install.sh
RUN echo 'test -n "$INTERACTIVE_CONFIG" && tail -f /dev/null || bash /RainbowMiner/start.sh' > /entrypoint.sh

RUN mkdir -p /etc/OpenCL/vendors && \
    find /opt/rocm -name "libamdocl64.so" 2>/dev/null | head -n 1 > /etc/OpenCL/vendors/amdocl64.icd
RUN rm -rf /var/lib/apt/lists/*

ENV AMD_VISIBLE_DEVICES=0
ENTRYPOINT bash /entrypoint.sh
