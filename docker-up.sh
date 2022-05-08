#!/usr/bin/env bash

export XAUTH_TOKEN=$(xauth list | head)
exec docker-compose run carla
