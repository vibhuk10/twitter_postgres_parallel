#!/bin/sh

python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:1934/ --inputs "$1"
