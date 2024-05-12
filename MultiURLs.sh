#!/bin/bash

echo -e $Yellow "
             _       _                   _       
            | |  _  (_)                 | |      
 ____  _   _| |_| |_ _       _   _  ____| |  ___ 
|    \| | | | (_   _) |     | | | |/ ___) | /___)
| | | | |_| | | | |_| |     | |_| | |   | ||___ |
|_|_|_|____/ \_) \__)_|     |____/|_|    \_|___/ 
                                                 
    @iamDK26 aka CISCO  Credits: @imran407704
"

# Check if the correct number of arguments is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename=$1
# Check if the target file exists in the current directory
if [ ! -f "$filename" ]; then
    echo "Target file '$filename' not found in the current directory."
    exit 1
fi

# Get the full path of the target file
target="$(pwd)/$filename"

printf "Total Targets: $(wc -l "$target" | awk '{print $1}')\n"
mkdir -p multiurls
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Waybackurls Started\n"
cat "$target" | waybackurls | anew multiurls/waybackurls.txt > /dev/null
printf "✅ Waybackurls data: $(wc -l multiurls/waybackurls.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Gau-Plus Started\n"
cat "$target" | gauplus | anew multiurls/plus-gau.txt > /dev/null
printf "✅ Plus-gau data: $(wc -l multiurls/plus-gau.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Gau Data Started\n"
cat "$target" | gau --subs | anew multiurls/gau.txt > /dev/null
printf "✅ Gau data: $(wc -l multiurls/gau.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Katana Data Started\n"
katana -u "$target" -silent  -jc | anew multiurls/katana.txt > /dev/null
printf "✅ Katana data: $(wc -l multiurls/katana.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Hakrawler Data Started\n"
cat "$target" | httprobe | hakrawler -subs -u | anew multiurls/hakrawler.txt > /dev/null
printf "✅ Hakrawler data: $(wc -l multiurls/hakrawler.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Waymore Data Started\n"
waymore -i "$target" -mode U -oU multiurls/waymore.txt
printf "✅ Waymore data: $(wc -l multiurls/waymore.txt | awk '{print $1}')\n"

cat multiurls/waybackurls.txt multiurls/plus-gau.txt multiurls/gau.txt multiurls/katana.txt multiurls/hakrawler.txt multiurls/waymore.txt | sort -u | anew multiurls/all-urls.txt > /dev/null

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

printf "Total all-urls: $(wc -l multiurls/all-urls.txt)\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
