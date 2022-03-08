FROM debian:11.2-slim

ENV DEBIAN_FRONTEND=noninteractive

# install general packages
RUN apt-get update && apt-get install -y --no-install-recommends curl gnupg ca-certificates
RUN curl -fsSL https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB | apt-key add -
RUN echo "deb [trusted=yes] https://apt.repos.intel.com/oneapi all main " > /etc/apt/sources.list.d/oneAPI.list
RUN apt-get update && apt-get install -y --no-install-recommends gcc g++ libgmp-dev libmpfr-dev make
RUN apt-get update && apt-get install -y --no-install-recommends intel-oneapi-compiler-dpcpp-cpp intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic

WORKDIR /workdir
COPY ./dSFMT/ /dSFMT/
COPY ./exflib/ /exflib/

ENV TBBROOT="/opt/intel/oneapi/tbb/2021.5.1/env/.."
ENV ONEAPI_ROOT="/opt/intel/oneapi"
ENV PKG_CONFIG_PATH="/opt/intel/oneapi/tbb/2021.5.1/env/../lib/pkgconfig:/opt/intel/oneapi/dpl/2021.6.0/lib/pkgconfig:/opt/intel/oneapi/compiler/2022.0.2/lib/pkgconfig"
ENV FPGA_VARS_DIR="/opt/intel/oneapi/compiler/2022.0.2/linux/lib/oclfpga"
ENV DPL_ROOT="/opt/intel/oneapi/dpl/2021.6.0"
ENV MANPATH="/opt/intel/oneapi/debugger/2021.5.0/documentation/man:/opt/intel/oneapi/compiler/2022.0.2/documentation/en/man/common:"
ENV GDB_INFO="/opt/intel/oneapi/debugger/2021.5.0/documentation/info/"
ENV CMAKE_PREFIX_PATH="/opt/intel/oneapi/tbb/2021.5.1/env/..:/opt/intel/oneapi/compiler/2022.0.2/linux/IntelDPCPP"
ENV CMPLR_ROOT="/opt/intel/oneapi/compiler/2022.0.2"
ENV INFOPATH="/opt/intel/oneapi/debugger/2021.5.0/gdb/intel64/lib"
ENV LIBRARY_PATH="/opt/intel/oneapi/tbb/2021.5.1/env/../lib/intel64/gcc4.8:/opt/intel/oneapi/compiler/2022.0.2/linux/compiler/lib/intel64_lin:/opt/intel/oneapi/compiler/2022.0.2/linux/lib"
ENV OCL_ICD_FILENAMES="libintelocl_emu.so:libalteracl.so:/opt/intel/oneapi/compiler/2022.0.2/linux/lib/x64/libintelocl.so"
ENV INTELFPGAOCLSDKROOT="/opt/intel/oneapi/compiler/2022.0.2/linux/lib/oclfpga"
ENV LD_LIBRARY_PATH="/opt/intel/oneapi/tbb/2021.5.1/env/../lib/intel64/gcc4.8:/opt/intel/oneapi/debugger/2021.5.0/gdb/intel64/lib:/opt/intel/oneapi/debugger/2021.5.0/libipt/intel64/lib:/opt/intel/oneapi/debugger/2021.5.0/dep/lib:/opt/intel/oneapi/compiler/2022.0.2/linux/lib:/opt/intel/oneapi/compiler/2022.0.2/linux/lib/x64:/opt/intel/oneapi/compiler/2022.0.2/linux/lib/oclfpga/host/linux64/lib:/opt/intel/oneapi/compiler/2022.0.2/linux/compiler/lib/intel64_lin"
ENV NLSPATH="/opt/intel/oneapi/compiler/2022.0.2/linux/compiler/lib/intel64_lin/locale/%l_%t/%N"
ENV PATH="/opt/intel/oneapi/dev-utilities/2021.5.2/bin:/opt/intel/oneapi/debugger/2021.5.0/gdb/intel64/bin:/opt/intel/oneapi/compiler/2022.0.2/linux/lib/oclfpga/bin:/opt/intel/oneapi/compiler/2022.0.2/linux/bin/intel64:/opt/intel/oneapi/compiler/2022.0.2/linux/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV INTEL_PYTHONHOME="/opt/intel/oneapi/debugger/2021.5.0/dep"
ENV CPATH="/opt/intel/oneapi/tbb/2021.5.1/env/../include:/opt/intel/oneapi/dpl/2021.6.0/linux/include:/opt/intel/oneapi/dev-utilities/2021.5.2/include"

CMD [ "bash" ]
