#!/usr/bin/env python3

import csv
import os
import re

import argparse
import sys

parser = argparse.ArgumentParser(prog="add_domains_to_orthogroups.py", description="A program to integrate Pfam domains with orthogroup counts")
parser.add_argument("--orthogroups", default='Orthogroups.tsv',help="The orthogroups file", type=str)
parser.add_argument("--outname", default='Orthogroups.Counts_with_Domains.tsv',help="The orthogroups output file", type=str)

parser.add_argument("--domaindir", default='.',help="The directory pfam domtbls are", type=str)
parser.add_argument("--domainext", default='Pfam.domtbl',help="The extension of all the files which are domtbl out files from Pfam/Hmmer", type=str)
args = parser.parse_args()
groupsfile = args.orthogroups
domaindir = args.domaindir

orthogroups_data = {}
species_names = []
with open(groupsfile, "r") as orthotbl:
    orthotbltsv = csv.reader(orthotbl,delimiter="\t")
    header = next(orthotbltsv)
    species_names = header[1:]
    for row in orthotbltsv:
        og = row[0]
        orthogroups_data[og] = {}
        for i in range(1,len(header)):
            genelist = []
            if len(row[i].strip()) > 0:
                genelist = row[i].strip().split(", ")
            orthogroups_data[og][header[i]] = genelist
            # print(orthogroups_data[og][header[i]])        
print(len(orthogroups_data))
print(species_names)

genes2domains = {}
for file in os.listdir(domaindir):
    if file.endswith(args.domainext):
        speciesname = file.replace("." + args.domainext, "")
        with open(os.path.join(domaindir,file),"r") as infh:
            for line in infh:
                if line.startswith("#"):
                    continue
                line = line.strip()
                row = line.split(None,22)
                domain_name = row[0]
                # if you wanted to take the text from this to use as description, grap row[22]
                if len(row) < 4:
                    print('line was empty', line)
                    continue
                protein_name = row[3]
                if protein_name not in genes2domains:
                    genes2domains[protein_name] = set()
                    # if you wanted to count the number of times a domain was present you would change this to a dictionary and add up below not add() to the set
                    # gene2domains[protein_name] = {}
                genes2domains[protein_name].add(domain_name)           

with open(args.outname, "w") as outfh:
    outtsv = csv.writer(outfh,delimiter="\t")
    headerrow = ['Orthogroups']
    headerrow.extend(species_names)
    headerrow.extend(['Totals','Domains'])
    outtsv.writerow(headerrow)
    for orthogroup in orthogroups_data:
        row = [orthogroup]
        all_domains = {}
        # loop through all species
        total = 0
        for sp in species_names:
            genes = orthogroups_data[orthogroup][sp]             
            # loop through all genes in a species in a given orthogrp
            for gene in genes:
                total += 1
                # loop through any domains this gene might have
                if gene in genes2domains:
                    # if the gene has domains loop through them
                    for domain in genes2domains[gene]:
                        if domain not in all_domains:
                            all_domains[domain] = 0
                        all_domains[domain] += 1
            row.append(len(genes))
        row.append(total)
        domain_text = []
        for domain in all_domains:
            domain_text.append(f'{domain} ({all_domains[domain]})')
        row.append(",".join(domain_text))
        outtsv.writerow(row)
