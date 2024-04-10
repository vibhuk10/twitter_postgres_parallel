#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
time for file in $files; do
     unzip -p "$file" | sed 's/\\u0000//g' | psql "postgresql://postgres:pass@0.0.0.0:51932/postgres" -c "copy tweets_jsonb (data) from STDIN csv quote e'\x01' delimiter e'\x02';"
done

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time for file in $files; do
    python3 load_tweets.py --db "postgresql://postgres:pass@localhost:1933/postgres" --input "$file"
done

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time for file in $files; do
    python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:1934/ --inputs $file
done
