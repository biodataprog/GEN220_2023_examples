#!/usr/bin/bash -l
ln -s /bigdata/gen220/shared/data-examples/examples/Saccharomyces_cerevisiae.peps.fa.gz
pigz -dc Saccharomyces_cerevisiae.peps.fa.gz > Saccharomyces_cerevisiae.peps.fa
