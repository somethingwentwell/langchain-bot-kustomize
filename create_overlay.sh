#!/bin/bash  
  
while [ "$#" -gt 0 ]; do  
  case "$1" in  
    --overlay-folder-name) overlay_folder_name="$2"; shift 2;;  
    --postgres-pv-name) postgres_pv_name="$2"; shift 2;;  
    --postgres-data-path) postgres_data_path="$2"; shift 2;;  
    --insource-pv-name) insource_pv_name="$2"; shift 2;;  
    --insource-data-path) insource_data_path="$2"; shift 2;;  
    --insource-namespace) insource_namespace="$2"; shift 2;;  
    --insource-ingress-root-path) insource_ingress_root_path="$2"; shift 2;;  
    *) echo "Unknown parameter: $1"; exit 1;  
  esac  
done  
  
# Create the folder in the ../overlay directory  
mkdir "./kustomize/overlay/$overlay_folder_name"  
  
# Copy all files from the current folder to the new folder  
cp -r ./kustomize/templates/hostPathPV/* "./kustomize/overlay/$overlay_folder_name"  
  
# Replace the specific text in the files with the given variable values  
# for file in $(find "../../overlay/$overlay_folder_name" -type f); do  
#   sed -i "s/<postgres-pv-name>/$postgres_pv_name/g" "$file"  
#   sed -i "s/<postgres-data-path>/$postgres_data_path/g" "$file"  
#   sed -i "s/<insource-pv-name>/$insource_pv_name/g" "$file"  
#   sed -i "s/<insource-data-path>/$insource_data_path/g" "$file"  
#   sed -i "s/<insource-namespace>/$insource_namespace/g" "$file"  
#   sed -i "s/<insource-ingress-root-path>/$insource_ingress_root_path/g" "$file"  
# done  

# FOR MAC USERS 
export LC_ALL=C  
export LANG=C  
for file in $(find "./kustomize/overlay/$overlay_folder_name" -type f); do  
  sed -i "" "s/<postgres-pv-name>/$postgres_pv_name/g" "$file"  
  sed -i "" "s/<postgres-data-path>/$postgres_data_path/g" "$file"  
  sed -i "" "s/<insource-pv-name>/$insource_pv_name/g" "$file"  
  sed -i "" "s/<insource-data-path>/$insource_data_path/g" "$file"  
  sed -i "" "s/<insource-namespace>/$insource_namespace/g" "$file"  
  sed -i "" "s/<insource-ingress-root-path>/$insource_ingress_root_path/g" "$file"  
done  
