#!/usr/bin/env bash

if [[ $(curl -s http://localhost:8080 | grep "Hello, World" | wc -l) -eq 1 ]]; then
  echo "Test complete, all good!"
  exit 0
else
  echo "Test failed, content is not being served"
  exit 1
fi