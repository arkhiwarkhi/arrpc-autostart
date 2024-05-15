#!/usr/bin/env bash

cd arrpc

node_pid=""

clean_up () {
  kill $node_pid
}

node src &
node_pid=$!

trap 'clean_up' EXIT
