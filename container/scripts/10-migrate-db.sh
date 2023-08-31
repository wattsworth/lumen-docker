#!/bin/sh
# Migrate the rails database
set -e
echo "===== Migrating Rails Database ====="
/home/app/bin/rails db:migrate
