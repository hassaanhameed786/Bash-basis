#! /bin/bash

NUM1=3
NUM2=5

if[ "$NUM1" -gt "$NUM2" ];
then
    echo "$NUM1 is greter than  $NUM2"
else
    echo "$NUM2 is greter than $NUM1"
fi