#!/usr/bin/env bash
# Parser piosenek ciągnie Fluttera (SongRaw), więc `dart run` nie działa.
# Odpalamy przez `flutter test`; argumenty idą zmienną środowiskową,
# rozdzielone znakiem \x1f (bezpieczne dla spacji i cudzysłowów).
set -euo pipefail
cd "$(dirname "$0")"
args=""
for a in "$@"; do args+="${a}"$'\x1f'; done
PIOSENKOMAT_CLI=1 PIOSENKOMAT_ARGS="${args%$'\x1f'}" \
  exec flutter test test/cli_harness.dart --reporter compact
