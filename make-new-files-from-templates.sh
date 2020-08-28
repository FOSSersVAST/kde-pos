#!/bin/bash

# Make new .po files
pots=$(find upstream/l10n-kf5-summit/templates/kdenetwork -name *.pot -type f)
for templatepath in $pots; do
    filepath=${templatepath/upstream\/l10n-kf5-summit\/templates\//l10n-kf5\/ml/}
    filepath=${filepath%.pot}.po
    if [ ! -f $filepath ]; then
        msginit -o $filepath -i $templatepath --no-translator --locale=ml_IN
    fi
    sed -i 's/Language-Team: none/Language-Team: SMC <smc.org.in>/' $filepath
done
