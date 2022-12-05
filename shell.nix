{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell { buildInputs = [ ruby_3_1 ]; }
