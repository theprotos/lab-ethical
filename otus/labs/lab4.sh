#!/usr/bin/bash

useradd -m -s /bin/sh newuser

id
who
groups

tail -f /etc/shadow