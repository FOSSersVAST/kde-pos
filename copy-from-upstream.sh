#!/usr/bin/env bash

pos_path=$(realpath l10n-kf5/ml)
upstream_path=$(realpath upstream/l10n-kf5-summit/ml)

pos=$(find $pos_path -name *.po -type f)
for po_path in $pos; do
    # PO files's path in upstream
    target_path=${po_path/$pos_path/$upstream_path}

    if [ ! -f $target_path ]; then
        echo "File doesn't exist : $target_path"
    else
        cp $target_path $po_path
        echo $po_path
    fi
done;