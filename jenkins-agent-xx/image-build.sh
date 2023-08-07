#!/bin/bash
docker build -t inbound-agent-xx .
docker tag inbound-agent-xx jgmurua/inbound-agent-xx:latest
docker push jgmurua/inbound-agent-xx:latest