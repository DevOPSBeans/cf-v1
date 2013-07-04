#!/bin/bash

ACTION=${1:-stop}
shift
VCAP_DEV=/home/sistemas/cloudfoundry/vcap/dev_setup/bin/vcap_dev

${VCAP_DEV} ${ACTION} $@
