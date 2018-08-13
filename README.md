# OpenDXL-Anomali-STAXX - Docker Repository

Introduction
============

This repository contains files related to the [OpenDXL-Anomali-STAXX](https://github.com/marcelosz/OpenDXL-Anomali-STAXX) app. The Docker image can be used as an alternative to installing a Python environment with the modules required to run the app.

The remainder of this page walks through the steps required to configure the app, pull an image from the repository and run the app via a Docker container.

Configuration
=============

The first step is to connect to the host that is running Docker and configure the app. All configuration files that are required by the app will reside on the host system and be made available to the Docker container via a data volume.

Once you have logged into the host system, perform the following steps:

1. Create a directory to contain the configuration files (ex.: /opt/dxlstaxx-config)

2. Add the configuration files for the app into that directory. Sample configuration files can be downloaded [here](https://github.com/marcelosz/OpenDXL-Anomali-STAXX/tree/master/conf).

3. Create a directory under dxlstaxx-config called dxlconfig.

4. Copy OpenDXL configuration files into that new directory.

Downloading and Running
===

The next step is to pull the image from the Docker repository. That can be done using the following Docker command:

> docker pull marcelosz/opendxl-anomali-staxx:latest

After pulling the image, the final step is to create a Docker container. The following Docker command can be used:

> docker run -d --name opendxl-anomali-staxx -v `<host-config-dir>`:/opt/OpenDXL-Anomali-STAXX/conf -e LOG_LEVEL='`<log-level>`' -e POLLING_TIME='`<polling-time>`' -e FILTER_QUERY='`<filter-query>`' marcelosz/opendxl-anomali-staxx:`<release-version>`

The following parameters must be specified:

`host-console-port`: The port used to access the OpenDXL Console via the host system

`host-config-dir`: The directory on the host that contains the console configuration files

`log-level`: The desired level of logging for OpenDXL Webhooks Server (DEBUG, INFO or ERROR)

`polling-time`: Polling time (in seconds)

`filter-query`:  Query used to filter desired observables (confidence, type, time window, ...)

`release-version`: The version of the image (See "Pull Docker Image" section above)

For example:

> docker run -d --name opendxl-anomali-staxx -v /opt/dxlstaxx-config:/opt/OpenDXL-Anomali-STAXX/conf -e LOG_LEVEL='INFO' -e POLLING_TIME='60' -e FILTER_QUERY='confidence>50 and date_last>-1m and itype=ddos_ip' marcelosz/opendxl-anomali-staxx:latest

**Note**: A restart policy can be specified via the `--restart <policy>` flag. This flag can be used to restart the container when the system reboots or if the service terminates abnormally. The `unless-stopped` policy will restart the container unless it has been explicitly stopped.
