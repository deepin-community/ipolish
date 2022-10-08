# vim:ts=2:et:sw=2:sts=2
#
# Simple tests for ipolish source package
#
# (C) 2021 Robert Luberda <robert@debian.org>
#

set -e

export LC_ALL=C.UTF-8
export PATH=/usr/bin:$PATH

datadir="$(readlink -e $(dirname $0)/data)"
tmpdir="$(mktemp -d)"
# trap "rm -rf $tmpdir" EXIT INT TERM
recode=0
misspelled=0


die()
{
  echo "$(basename $0) ERROR: $@" >&2
  exit 1
}

[ "$1" ] || die "Missing required argument"

while [ "$1" ]; do
  case "$1" in
    --recode)
      recode=1
      ;;
    --misspelled)
      misspelled=1
      ;;
    --)
      shift
      break
      ;;
    --*)
      die "Unrecognied option: $1"
      ;;
    *)
      datafile="$1"
      ;;
  esac
  shift
done

[ "$datafile" ] || die "Missing required datafile argument"
[ -e "$datadir/$datafile" ] || die "$datadir/$datafile does not exist"
