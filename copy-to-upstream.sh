#!/usr/bin/env bash

pos_path=$(realpath l10n-kf5/ml)
upstream_path=$(realpath upstream/l10n-kf5-summit/ml)
upstream_template_path=$(realpath upstream/l10n-kf5-summit/templates)

pos=$(find $pos_path -name *.po -type f)
for po_path in $pos; do
    pot_path=${po_path/$pos_path/$upstream_template_path}t
    upstream_po_path=${po_path/$pos_path/$upstream_path}

    if [ ! -f $upstream_po_path ]; then
        echo "File doesn't exist : $upstream_po_path"
    else
        # Copy all localized strings from po to target even if it's null
        # wrapping is disabled in summit repos
        msgmerge --no-wrap --compendium $po_path -o $upstream_po_path $po_path $pot_path
        echo $po_path
    fi
done;