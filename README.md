# copurchase-scalable
Co-purchase analysis project for Scalable and Cloud Programming course at University of Bologna

./scripts/fetch-thirdparty.sh
./scripts/build.sh
./scripts/bucket-upload.sh build/CoPurchaseAnalysis.jar
./scripts/bucket-upload.sh dataset/order_products.csv
./scripts/scalability-analysis.sh --workers=1
./scripts/scalability-analysis.sh --workers=2
./scripts/scalability-analysis.sh --workers=3
./scripts/scalability-analysis.sh --workers=4

./scripts/describe-cluster.sh, open YARN ResourceManager link on browerser, click on application ID, click on Tracking URL
