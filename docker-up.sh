#!/usr/bin/env bash

export XAUTH_TOKENS="$(xauth list)"
exec docker-compose run carla
