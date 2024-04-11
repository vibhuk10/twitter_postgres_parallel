#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
# FIXME: implement this with GNU parallel
echo "$files" | time parallel ./load_denormalized.sh

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
# FIXME: implement this with GNU parallel
echo "$files" | time parallel ./load_normalized.sh

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
# FIXME: implement this with GNU parallel
echo "$files" | time parallel ./load_normalized_batch.sh
