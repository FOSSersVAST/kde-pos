#!/usr/bin/env bash

pos_path=$(realpath pos/ml)
upstream_path=$(realpath upstream/summit/ml)
upstream_template_path=$(realpath upstream/summit/templates)

pos=$(find $pos_path -name *.po -type f)
for po_path in $pos; do
    pot_path=${po_path/$pos_path/$upstream_template_path}t
    upstream_po_path=${po_path/$pos_path/$upstream_path}

    if [ ! -f $upstream_po_path ]; then
        echo "File doesn't exist : $upstream_po_path"
    else
        # cp $upstream_po_path $po_path

        # Copy all localized strings from po to target even if it's null
        # wrapping is enabled in weblate
        msgmerge --compendium $upstream_po_path -o $po_path $upstream_po_path $pot_path
        echo $po_path
    fi
done;
