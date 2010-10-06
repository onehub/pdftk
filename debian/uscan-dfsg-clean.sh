#!/bin/sh 

set -e

#command --upstream-version version filename

[ $# -eq 3 ] || exit 255

version="$2"
filename="$3"
dfsgfilename=`echo $3 | sed 's,\.orig\.,+dfsg.orig.,'`

tar xfz ${filename} 

dir=`( tar tfz ${filename} || true ) | head -2 | tail -1 | sed -e 's,^./,,' -e 's,/.*,,g'`
rm -f ${filename}

rm -rf ${dir}/java_libs*
rm -rf ${dir}/debian
mv ${dir} ${dir}+dfsg

tar cf - ${dir}+dfsg | gzip -9 > ${dfsgfilename}

rm -rf ${dir}+dfsg

echo "${dfsgfilename} created."
