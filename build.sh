#!/usr/bin/env bash

mod_name=`jq -r '.name' mod/info.json`
mod_ver=`jq -r '.version' mod/info.json`

echo -e "Building \e[92m${mod_name}_${mod_ver}\e[0m.."

cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${cwd}

rm -rf build/${mod_name}_${mod_ver}
rm -rf build/${mod_name}_${mod_ver}.zip

mkdir build/${mod_name}_${mod_ver}
cp -r mod/* build/${mod_name}_${mod_ver}

cd build
zip -r ${mod_name}_${mod_ver}.zip ${mod_name}_${mod_ver}
rm -rf ${mod_name}_${mod_ver}

echo "Complete"
