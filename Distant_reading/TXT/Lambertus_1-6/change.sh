#!/bin/bash

for f in C_PRIMVM_v*.txt; do
  mv -- "$f" "${f/C_PRIMVM_v/C_I_v}"
done
