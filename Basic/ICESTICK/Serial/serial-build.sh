#!/bin/bash

rm -f serial.json serial.asc serial.bin

#yosys -p 'synth_ice40 -json $@' $< 

yosys -p 'synth_ice40 -json serial.json'  serial.v uart.v

#nextpnr-ice40 --hx8k -r --freq 50 --package ct256 --pcf $*.pcf --json $< --asc $@

nextpnr-ice40 --hx8k  --package ct256 --pcf-allow-unconstrained --pcf serial.pcf --json serial.json --asc serial.asc

#nextpnr-ice40 --hx8k  --package ct256  --pcf serial.pcf --json serial.json --asc serial.asc

icepack serial.asc serial.bin

icetime -d hx8k -c 100 serial.asc
