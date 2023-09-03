#bad  sed -e 's/&/&amp;/g' -e 's/</&lt;/g' "$1" >> "$2"
#sed -e 's/[^\^]&/\&amp;/g' -e 's/</\&lt;/g' "$1" >> "$2"
sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' "$1" >> "$2"
