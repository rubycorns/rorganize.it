#!/bin/bash
#
# This script is meant to run on Travis. It deploys via git push to
# the target server.
set -e

cat << EOF >> ~/.ssh/config
Host rorganize.it
StrictHostKeyChecking no
EOF

git remote add production ror@rorganize.it:rorganize.it
git push -f production master
