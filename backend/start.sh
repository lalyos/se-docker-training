#!/bin/bash

psql -U postgres -c 'select * from training;' -h $DB_HOST
