#!/bin/bash
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -o split_%j.out
#SBATCH -e split_%j.err
#SBATCH -J split

#fail if there's a typo in variable names
set -u
#fail if any command fails
set -e

# if there are cir_rep_contigs
if [[ -s "$2" ]]; then

  cd "$1"
  mkdir unicycler
  cp cir_rep_contigs.fasta unicycler/
  cd unicycler
  awk '/^>/{s=++d".fasta"} {print > s}' cir_rep_contigs.fasta
  rm cir_rep_contigs.fasta

else

  echo "WARNING: no circular contigs found; continuing with only linear contigs" >&2

fi
