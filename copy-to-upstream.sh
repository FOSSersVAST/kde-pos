#!/usr/bin/env bash

pos_path=$(realpath l10n-kf5/ml)
upstream_path=$(realpath upstream/l10n-kf5-summit/ml)

pos=$(find $pos_path -name *.po -type f)
for po_path in $pos; do
    target_path=${po_path/$pos_path/$upstream_path}

    if [ ! -f $target_path ]; then
        echo "File doesn't exist : $target_path"
    else
        # Copy all localized strings from po to target even if it's null
        msgmerge --compendium $po_path -o $target_path /dev/null $target_path;
        echo $po_path
    fi
done;