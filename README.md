# copurchase-scalable
Co-purchase analysis project for Scalable and Cloud Programming course 2024-2025 at University of Bologna.

## How to repeat the time measurements

All measurements were taken on a Google Cloud Custer, using command line scripts launched from a GNU/Linux Debian 12 x86_64 machine.

```
git clone https://github.com/llllluca/copurchase-scalable.git
cd copurchase-scalable/
```

### 1. Install thridpary dependancy

This script creates the thrirdpary directory and downloads into it the Google Cloud CLI, Scala version 2.12.18 and Spark 3.5.3, these are the versions of Scala and Spark pre-installed on the image 2.2.53-debian12 used in all machine of the Google Cloud cluster used for these time measurements.

```
./scripts/fetch-thirdparty.sh
```

### 2. Google Cloud login
Authenticate with your Google account.
```
./thirdparty/google-cloud-sdk/bin/gcloud auth login
```

### 3. Create the Google Cloud bucket storage 
```
./scripts/bucket-create.sh
```

### 5. Build the jar files
```
./scripts/build.sh
```

### 6. Unzip the dataset
```
cd dataset/
gunzip --keep  order_products_1.csv.gz
gunzip --keep  order_products_2.csv.gz
cat order_products_1.csv order_products_2.csv > order_products.csv
cd ..
```

### 7. Upload the jar files and the dataset on the bucket
```
./scripts/bucket-upload.sh build/CoPurchaseAnalysis.jar
./scripts/bucket-upload.sh build/CoPurchaseAnalysisNoPartitioning.jar
./scripts/bucket-upload.sh dataset/order_products.csv
```
### 8. Perform time measurements on CoPurchaseAnalysisNoPartitioning

```
./scripts/scalability-analysis.sh --no-partitioning --workers=1 
./script/time.py summary_1_workers_no_partitioning.json
# The output files are in the output_1_workers_no_partitioning/ directory.
```

The script `scalability-analysis.sh` with the parameter `--no-partitioning` and `--workers=1` perform the following steps:

1. Create a cluster with 1 worker.
2. Execute `CoPurchaseAnalysisNoPartitioning.jar` on the cluster.
3. Save the file `summary_1_workers_no_partitioning.json` with the summary of the execution of `CoPurchaseAnalysisNoPartitioning.jar` on the cluster, including the start time and end time.
4. Download the output directory `output_1_workers_no_partitioning/`
5. Delete the cluster.

The script `time.py` print the wall clock time in minutes and seconds.

Increasing the `--workers=N` parameter  change the number of workers in the cluster.

```
./scripts/scalability-analysis.sh --no-partitioning --workers=2
./script/time.py summary_2_workers_no_partitioning.json
# The output files are in the output_2_workers_no_partitioning/ directory.

./scripts/scalability-analysis.sh --no-partitioning --workers=3
./script/time.py summary_3_workers_no_partitioning.json
# The output files are in the output_3_workers_no_partitioning/ directory.

./scripts/scalability-analysis.sh --no-partitioning --workers=4
./script/time.py summary_4_workers_no_partitioning.json
# The output files are in the output_4_workers_no_partitioning/ directory.
```

### 9. Perform time measurements on CoPurchaseAnalysis
```
./scripts/scalability-analysis.sh --workers=1
./script/time.py summary_1_workers.json
# The output files are in the output_1_workers/ directory.
```

The script `scalability-analysis.sh` with only the parameter `--workers=1` perform the following steps:

1. Create a cluster with 1 worker.
2. Execute `CoPurchaseAnalysis.jar` on the cluster.
3. Save the file `summary_1_workers.json` with the summary of the execution of `CoPurchaseAnalysis.jar` on the cluster, including the start time and end time.
4. Download the output directory `output_1_workers/`
5. Delete the cluster.

The script `time.py` print the wall clock time in minutes and seconds.

Increasing the `--workers=N` parameter  change the number of workers in the cluster.

```
./scripts/scalability-analysis.sh --workers=2
./script/time.py summary_1_workers.json
# The output files are in the output_1_workers/ directory.

./scripts/scalability-analysis.sh --workers=3
./script/time.py summary_1_workers.json
# The output files are in the output_1_workers/ directory.

./scripts/scalability-analysis.sh --workers=4
./script/time.py summary_4_workers.json
# The output files are in the output_1_workers/ directory.
```

