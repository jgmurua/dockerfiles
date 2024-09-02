#!/bin/bash

ROOT_DIR=/opt/cronicle
CONF_DIR=$ROOT_DIR/conf
BIN_DIR=$ROOT_DIR/bin

DATA_DIR=$ROOT_DIR/data
LOGS_DIR=$ROOT_DIR/logs
PLUGINS_DIR=$ROOT_DIR/plugins

# The env variables below are needed for Docker and cannot be overwritten
export CRONICLE_Storage__Filesystem__base_dir=${DATA_DIR}
export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt
export CRONICLE_echo=1
export CRONICLE_foreground=1

if [ ! -f $DATA_DIR/.setup_done ]
then
  $BIN_DIR/control.sh setup
  cp $CONF_DIR/config.json $CONF_DIR/config.json.origin

  mkdir -p $PLUGINS_DIR
  touch $DATA_DIR/.setup_done
fi

PID_FILE=$LOGS_DIR/cronicled.pid
if [ -f "$PID_FILE" ]; then
  rm -f $PID_FILE
fi

if [ -n "$1" ];
then
  exec "$@"
else
  /opt/cronicle/bin/control.sh start
fi
