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

# Index ga_ls8c_ard_3
s3-to-dc 's3://dea-public-data/baseline/ga_ls8c_ard_3/111/073/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls8c_ard_3'  # Roebuck 1, 2020
s3-to-dc 's3://dea-public-data/baseline/ga_ls8c_ard_3/110/073/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls8c_ard_3'  # Roebuck 2, 2020

# # Index ga_ls8c_ard_3
# s3-to-dc 's3://dea-public-data/baseline/ga_ls8c_ard_3/089/079/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls8c_ard_3'  # Brisbane, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_ls8c_ard_3/095/082/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls8c_ard_3'  # Menindee 1, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_ls8c_ard_3/095/083/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls8c_ard_3'  # Menindee 2, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_ls8c_ard_3/090/084/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls8c_ard_3'  # Canberra 1, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_ls8c_ard_3/090/085/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls8c_ard_3'  # Canberra 2, 2020

# # Index ga_ls7e_ard_3
# s3-to-dc 's3://dea-public-data/baseline/ga_ls7e_ard_3/089/079/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls7e_ard_3'  # Brisbane, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_ls7e_ard_3/095/082/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls7e_ard_3'  # Menindee 1, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_ls7e_ard_3/095/083/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls7e_ard_3'  # Menindee 2, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_ls7e_ard_3/090/084/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls7e_ard_3'  # Canberra 1, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_ls7e_ard_3/090/085/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls7e_ard_3'  # Canberra 2, 2020

# # Index ga_s2am_ard_3
# s3-to-dc 's3://dea-public-data/baseline/ga_s2am_ard_3/56/JNQ/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2am_ard_3'  # Brisbane, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_s2am_ard_3/54/HXK/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2am_ard_3'  # Menindee, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_s2am_ard_3/55/HFB/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2am_ard_3'  # Canberra 1, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_s2am_ard_3/55/HFA/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2am_ard_3'  # Canberra 2, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_s2am_ard_3/55/HGB/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2am_ard_3'  # Canberra 3, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_s2am_ard_3/55/HGA/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2am_ard_3'  # Canberra 4, 2020

# # Index ga_s2bm_ard_3
# s3-to-dc 's3://dea-public-data/baseline/ga_s2bm_ard_3/56/JNQ/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2bm_ard_3'  # Brisbane, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_s2bm_ard_3/54/HXK/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2bm_ard_3'  # Menindee, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_s2bm_ard_3/55/HFB/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2bm_ard_3'  # Canberra 1, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_s2bm_ard_3/55/HFA/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2bm_ard_3'  # Canberra 2, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_s2bm_ard_3/55/HGB/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2bm_ard_3'  # Canberra 3, 2020
# s3-to-dc 's3://dea-public-data/baseline/ga_s2bm_ard_3/55/HGA/2020/*/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_s2bm_ard_3'  # Canberra 4, 2020

# # Index ga_ls_wo_3
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_3/1-6-0/089/079/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_wo_3'  # Brisbane, 2020
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_3/1-6-0/095/082/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_wo_3'  # Menindee 1, 2020
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_3/1-6-0/095/083/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_wo_3'  # Menindee 2, 2020
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_3/1-6-0/090/084/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_wo_3'  # Canberra 1, 2020
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_3/1-6-0/090/085/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_wo_3'  # Canberra 2, 2020

# # Index ga_ls_fc_3
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_fc_3/2-5-0/089/079/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_fc_3'  # Brisbane, 2020
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_fc_3/2-5-0/095/082/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_fc_3'  # Menindee 1, 2020
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_fc_3/2-5-0/095/083/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_fc_3'  # Menindee 2, 2020
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_fc_3/2-5-0/090/084/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_fc_3'  # Canberra 1, 2020
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_fc_3/2-5-0/090/085/2020/*/*/*.json' --no-sign-request --skip-lineage --stac 'ga_ls_fc_3'  # Canberra 2, 2020

# # Index ga_ls_wo_fq_cyear_3
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_fq_cyear_3/1-6-0/x49/y24/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls_wo_fq_cyear_3'  # Brisbane, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_fq_cyear_3/1-6-0/x38/y20/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls_wo_fq_cyear_3'  # Menindee 1, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_fq_cyear_3/1-6-0/x37/y19/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls_wo_fq_cyear_3'  # Menindee 2, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_fq_cyear_3/1-6-0/x38/y19/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls_wo_fq_cyear_3'  # Menindee 3, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_fq_cyear_3/1-6-0/x44/y16/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls_wo_fq_cyear_3'  # Canberra 1, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_wo_fq_cyear_3/1-6-0/x44/y15/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls_wo_fq_cyear_3'  # Canberra 2, all

# # Index ga_ls8c_nbart_gm_cyear_3
# s3-to-dc 's3://dea-public-data/derivative/ga_ls8c_nbart_gm_cyear_3/3-0-0/x49/y24/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls8c_nbart_gm_cyear_3'  # Brisbane, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls8c_nbart_gm_cyear_3/3-0-0/x38/y20/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls8c_nbart_gm_cyear_3'  # Menindee 1, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls8c_nbart_gm_cyear_3/3-0-0/x37/y19/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls8c_nbart_gm_cyear_3'  # Menindee 2, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls8c_nbart_gm_cyear_3/3-0-0/x38/y19/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls8c_nbart_gm_cyear_3'  # Menindee 3, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls8c_nbart_gm_cyear_3/3-0-0/x44/y16/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls8c_nbart_gm_cyear_3'  # Canberra 1, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls8c_nbart_gm_cyear_3/3-0-0/x44/y15/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls8c_nbart_gm_cyear_3'  # Canberra 2, all

# # Index ga_ls7e_nbart_gm_cyear_3
# s3-to-dc 's3://dea-public-data/derivative/ga_ls7e_nbart_gm_cyear_3/3-0-0/x49/y24/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls7e_nbart_gm_cyear_3'  # Brisbane, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls7e_nbart_gm_cyear_3/3-0-0/x38/y20/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls7e_nbart_gm_cyear_3'  # Menindee 1, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls7e_nbart_gm_cyear_3/3-0-0/x37/y19/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls7e_nbart_gm_cyear_3'  # Menindee 2, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls7e_nbart_gm_cyear_3/3-0-0/x38/y19/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls7e_nbart_gm_cyear_3'  # Menindee 3, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls7e_nbart_gm_cyear_3/3-0-0/x44/y16/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls7e_nbart_gm_cyear_3'  # Canberra 1, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls7e_nbart_gm_cyear_3/3-0-0/x44/y15/*/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls7e_nbart_gm_cyear_3'  # Canberra 2, all

# # Index ga_ls_landcover_class_cyear_2
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_landcover_class_cyear_2/1-0-0/*/x_20/y_-32/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls_landcover_class_cyear_2'  # Brisbane, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_landcover_class_cyear_2/1-0-0/*/x_9/y_-36/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls_landcover_class_cyear_2'  # Menindee, all
# s3-to-dc 's3://dea-public-data/derivative/ga_ls_landcover_class_cyear_2/1-0-0/*/x_15/y_-40/*.odc-metadata.yaml' --no-sign-request --skip-lineage 'ga_ls_landcover_class_cyear_2'  # Canberra, all
