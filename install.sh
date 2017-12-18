#!/usr/bin/env bash

mod_name=`jq -r '.name' mod/info.json`
mod_ver=`jq -r '.version' mod/info.json`

echo -e "Installing \e[92m${mod_name}_${mod_ver}\e[0m.."

cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${cwd}

cp build/${mod_name}_${mod_ver}.zip ~/.factorio/mods/
