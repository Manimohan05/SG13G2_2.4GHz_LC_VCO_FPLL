#!/usr/bin/env python3
"""Relabel an ngspice FFT raw file so the xschem waveform viewer can draw it.

ngspice writes the result of `fft` as plot "Spectrum" with a `frequency` scale, which xschem does not
recognise (its graph stays empty). This rewrites only the text header: the plot becomes a real-valued
"Transient Analysis" whose first variable is called `time` and holds the frequency values. The binary
data is untouched, so running it twice is harmless. The x axis of the graph is then labelled `time`
but its values are frequencies in Hz.

Usage: python3 raw_spectrum_as_tran.py LC_VCO_fft.raw
"""
import re, sys

fn = sys.argv[1]
b = open(fn, "rb").read()
i = b.index(b"Binary:\n") + len(b"Binary:\n")
h = b[:i].decode()
h = re.sub(r"Plotname:.*", "Plotname: Transient Analysis", h)
h = re.sub(r"Flags:.*", "Flags: real", h)
h = re.sub(r"(\n\t0\t)frequency\tfrequency", r"\1time\ttime", h)
open(fn, "wb").write(h.encode() + b[i:])
