 #!/bin/bash

# Fix Language team header value in .po files
pos=$(find upstream/l10n-kf5-trunk/ml -name *.po -type f)
for path in $pos; do
    if [ -f $path ]; then
        echo $path
        sed -i "s/Language-Team: .*\\\n\"/Language-Team: SMC <smc.org.in>\\\n\"/" $path
    fi
done
