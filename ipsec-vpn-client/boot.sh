#!/bin/bash

set -eo pipefail

confd -log-level=debug -onetime -backend env
