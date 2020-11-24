#!/bin/bash
set -ex

pushd $CIRCUIT_DIR
npx circom circuit.circom --r1cs --wasm --sym -v
npx snarkjs r1cs export json circuit.r1cs circuit.r1cs.json
# generate and verify proof
npx snarkjs calculatewitness # witness is still generated by snarkjs
popd
# (adhoc) contrain all unconstrained vars to 1, and generate json witness file
node $TOOL_DIR/process_circom_files.mjs $CIRCUIT_DIR
