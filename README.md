# docker-Borzoi
Dockerfile used to run [Borzoi](https://github.com/calico/borzoi) developed by calico.

## Installation

```bash
docker build -t borzoi .
```

## Download models and annotations

```bash
# Download the mini model and testing files
mkdir -p examples/files
wget -O examples/files/model0_best.h5 https://storage.googleapis.com/seqnn-share/borzoi/mini/k562_rna/f0/model0_best.h5
wget -O examples/files/targets.txt https://storage.googleapis.com/seqnn-share/borzoi/mini/k562_rna/hg38/targets.txt
wget -O examples/files/params.json https://storage.googleapis.com/seqnn-share/borzoi/mini/k562_rna/params.json

# Download large model and annotations
bash download_models.sh 
```

## Basic usage

```bash
docker run --rm -u $(id -u):$(id -g) \
           -v $(pwd):/home \
           -e BORZOI_HG38=/home/examples/hg38 \
           -it borzoi \
           borzoi_sed.py --rc --stats logSED,logD2 \
                         -o test \
                         -t examples/files/targets.txt \
                         examples/files/params.json examples/files/model0_best.h5 /borzoi/tutorials/latest/score_variants/snps_expr.vcf
```
