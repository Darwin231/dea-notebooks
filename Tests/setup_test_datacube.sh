#!/usr/bin/env bash

# pipe the exit code to the parent process
set -ex
set -o pipefail

# install indexing tool
pip3 install --no-cache --upgrade odc-apps-dc-tools

# Setup datacube
datacube system init --no-init-users

# clone dea-config
git clone https://github.com/GeoscienceAustralia/dea-config.git


# Setup metadata types
for metadata_yaml in $(find ./dea-config/product_metadata -name '*.yaml'); do
    datacube metadata add $metadata_yaml
done

# Index products we care about for dea-notebooks
for prod_def_yaml in $(find ./dea-config/products -name '*.yaml' -regex '.*\(ga_ls7e_nbart_gm_cyear_3\|ga_ls8c_nbart_gm_cyear_3\|ga_ls_fc_3\|ga_ls_wo_3\|ga_ls_wo_fq_cyear_3\|ga_ls_landcover_class_cyear_2\|high_tide_comp_20p\|low_tide_comp_20p\|ga_s2am_ard_3\|ga_s2bm_ard_3\|ga_ls5t_ard_3\|ga_ls7e_ard_3\|ga_ls8c_ard_3\|ga_ls9c_ard_3\).*'); do
        datacube product add $prod_def_yaml
done

datacube product list

# Index Landsat 8
s3-to-dc 's3://dea-public-data/baseline/ga_ls8c_ard_3/089/079/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls8c_ard_3'  # Brisbane, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_ls8c_ard_3/095/082/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls8c_ard_3'  # Menindee 1, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_ls8c_ard_3/095/083/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls8c_ard_3'  # Menindee 2, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_ls8c_ard_3/090/084/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls8c_ard_3'  # Canberra 1, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_ls8c_ard_3/090/085/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls8c_ard_3'  # Canberra 2, 2020

# Index Landsat 7
s3-to-dc 's3://dea-public-data/baseline/ga_ls7e_ard_3/089/079/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls7e_ard_3'  # Brisbane, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_ls7e_ard_3/095/082/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls7e_ard_3'  # Menindee 1, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_ls7e_ard_3/095/083/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls7e_ard_3'  # Menindee 2, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_ls7e_ard_3/090/084/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls7e_ard_3'  # Canberra 1, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_ls7e_ard_3/090/085/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls7e_ard_3'  # Canberra 2, 2020

# Index Sentinel-2A
s3-to-dc 's3://dea-public-data/baseline/ga_s2am_ard_3/56/JNQ/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2am_ard_3'  # Brisbane, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_s2am_ard_3/54/HXK/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2am_ard_3'  # Menindee, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_s2am_ard_3/55/HFB/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2am_ard_3'  # Canberra 1, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_s2am_ard_3/55/HFA/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2am_ard_3'  # Canberra 2, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_s2am_ard_3/55/HGB/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2am_ard_3'  # Canberra 3, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_s2am_ard_3/55/HGA/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2am_ard_3'  # Canberra 4, 2020

# Index Sentinel-2B
s3-to-dc 's3://dea-public-data/baseline/ga_s2bm_ard_3/56/JNQ/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2bm_ard_3'  # Brisbane, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_s2bm_ard_3/54/HXK/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2bm_ard_3'  # Menindee, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_s2bm_ard_3/55/HFB/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2bm_ard_3'  # Canberra 1, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_s2bm_ard_3/55/HFA/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2bm_ard_3'  # Canberra 2, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_s2bm_ard_3/55/HGB/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2bm_ard_3'  # Canberra 3, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_s2bm_ard_3/55/HGA/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2bm_ard_3'  # Canberra 4, 2020

# Index WO
s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_3/1-6-0/089/079/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_wo_3'  # Brisbane, 2020
s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_3/1-6-0/095/082/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_wo_3'  # Menindee 1, 2020
s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_3/1-6-0/095/083/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_wo_3'  # Menindee 2, 2020
s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_3/1-6-0/090/084/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_wo_3'  # Canberra 1, 2020
s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_3/1-6-0/090/085/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_wo_3'  # Canberra 2, 2020

# Index FC
s3-to-dc 's3://dea-public-data/derivative/ga_ls_fc_3/2-5-0/089/079/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_fc_3'  # Brisbane, 2020
s3-to-dc 's3://dea-public-data/derivative/ga_ls_fc_3/2-5-0/095/082/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_fc_3'  # Menindee 1, 2020
s3-to-dc 's3://dea-public-data/derivative/ga_ls_fc_3/2-5-0/095/083/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_fc_3'  # Menindee 2, 2020
s3-to-dc 's3://dea-public-data/derivative/ga_ls_fc_3/2-5-0/090/084/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_fc_3'  # Canberra 1, 2020
s3-to-dc 's3://dea-public-data/derivative/ga_ls_fc_3/2-5-0/090/085/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_fc_3'  # Canberra 2, 2020
