#!/bin/bash

for i in `seq 1 8` ; do
  to_wait=""

  data="scholar"
  ./text2sql-template-baseline.py ./text2sql-data-master/data/${data}.json --eval-freq 1000000 --log-freq 1000000 --max-bad-iters -1 --do-test-eval --max-iters 17 --lstm-layers 1 >out.${data}.${i}.txt 2>err.${data}.${i}.txt &
  to_wait="${to_wait} $!"

  data="geography"
  ./text2sql-template-baseline.py ./text2sql-data-master/data/${data}.json --eval-freq 1000000 --log-freq 1000000 --max-bad-iters -1 --do-test-eval --max-iters 31 --dim-word 64 --dim-hidden-lstm 128 --dim-hidden-template 32  >out.${data}.${i}.txt 2>err.${data}.${i}.txt &
  to_wait="${to_wait} $!"

  data="advising"
  ./text2sql-template-baseline.py ./text2sql-data-master/data/${data}.json --eval-freq 1000000 --log-freq 1000000 --max-bad-iters -1 --do-test-eval --max-iters 40 >out.${data}.${i}.txt 2>err.${data}.${i}.txt &
  to_wait="${to_wait} $!"

  data="atis"
  ./text2sql-template-baseline.py ./text2sql-data-master/data/${data}.json --eval-freq 1000000 --log-freq 1000000 --max-bad-iters -1 --do-test-eval --max-iters 22 --learning-rate 0.05 >out.${data}.${i}.txt 2>err.${data}.${i}.txt &
  to_wait="${to_wait} $!"

  wait $to_wait
done

for data in academic yelp imdb restaurants ; do
  for i in `seq 0 9` ; do
    ./text2sql-template-baseline.py ./text2sql-data-master/data/${data}.json --split $i --dim-word 64 --dim-hidden-template 32 --train-noise 0.0 --lstm-layers 1 --max-iters 3 --eval-freq 1000000 --log-freq 1000000 --max-bad-iters -1 --do-test-eval >out.${data}.split${i}.txt 2>err.${data}.split${i}.txt
  done
done