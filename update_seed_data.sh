#!/bin/bash
# Update seed data from downloaded Fineli zip archive.
# Download the archive from http://www.fineli.fi/showpage.php?page=opendata.
set -e -o pipefail

SCRIPTDIR=$(cd -P $(dirname $0); pwd)
SEEDDIR=$SCRIPTDIR/seed_data
HELP_WANTED=0
RETCODE=0

err () {
  echo ERROR: "$@" >&2
}

while (( "$#" )); do
  arg=$1
  case "$arg" in
    -h|--help)
      HELP_WANTED=1
      break
      ;;
    *)
      if [[ -n $ARCHIVE ]]; then
        RETCODE=1
        HELP_WANTED=1
        break
      fi
      ARCHIVE=$arg
      ;;
  esac
  shift
done

if [[ 1 -eq $HELP_WANTED ]]; then
  cat <<EOF
Usage: $0 [OPTIONS] ARCHIVE

Where ARCHIVE is the path of the archive to import as new seed data, and
OPTIONS can be one or more of:

    -h | --help             Output this help.
EOF
elif [[ ! -f $ARCHIVE ]]; then
  err "$ARCHIVE is not a file."
  RETCODE=1
elif [[ ! -e $ARCHIVE ]]; then
  err "$ARCHIVE is not readable."
  RETCODE=1
elif [[ -z $(which unzip) ]]; then
  err "unzip not found on PATH."
  RETCODE=1
elif [[ -z $(which iconv) ]]; then
  err "iconv not found on PATH."
  RETCODE=1
else
  echo "Unpacking:"
  unzip -j "$ARCHIVE" -x '*.pdf' -d "$SEEDDIR"
  echo "Done unpacking."
  echo "Transcoding to UTF-8:"
  CSVS=($SEEDDIR/*.csv)
  for f in "${CSVS[@]}"; do
    echo "  $f"
    mv "$f" "$f".orig
    iconv -f iso-8859-1 -t utf-8 < "$f".orig > "$f"
    rm -f "$f".orig
  done
  echo "Done transcoding."
fi

exit $RETCODE
