#!/bin/bash

module load VEP/86


input_vcf=$1
genome=$2
cores=$3

if [ "$genome" == "GRCh38" ] || [ "$genome" == "GRCh37" ]; then
	variant_effect_predictor.pl -i $input_vcf --offline \
	--cache --dir_cache $VEPCACHEDIR \
	--fasta $VEPCACHEDIR/$genome.fa --species human --assembly $genome  \
	--output ${input_vcf%.vcf}.VEP.$genome.vcf \
	--plugin Grantham \
	--plugin MaxEntScan,/home/mcgaugheyd/bin/MaxEntScan \
	--plugin CADD,/fdb/CADD/1.3/prescored/whole_genome_SNVs.tsv.gz,/fdb/CADD/1.3/prescored/InDels.tsv.gz \
	--total_length \
    --hgvs \
	--sift b \
    --polyphen b \
    --symbol \
    --numbers \
    --biotype \
    --total_length \
	--pubmed \
	--domains \
	--gene_phenotype \
    --fields Consequence,Codons,Amino_acids,Gene,SYMBOL,Feature,EXON,PolyPhen,SIFT,Protein_position,BIOTYPE,CANONICAL,DOMAINS,CLIN_SIG,Grantham,MaxEntScan,HGVSc,HGVSp,PUBMED,Phenotypes,CADD_RAW,CADD_PHRED \
	--vcf --force_overwrite --fork $cores
else
    echo "Pick either GRCh38 or GRCh37 genomes"
fi
