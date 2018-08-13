#!/bin/bash
python /opt/OpenDXL-Anomali-STAXX/staxx_exporter.py -c /opt/OpenDXL-Anomali-STAXX/conf/client.conf -l $LOG_LEVEL -p -t $POLLING_TIME "$FILTER_QUERY"
