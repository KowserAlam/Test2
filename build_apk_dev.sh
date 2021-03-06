#!/bin/bash
set -e

# Find and increment the version number.
perl -i -pe 's/^(version:\s+\d+\.\d+\.)(\d+)(\+)(\d+)$/$1.($2+1).$3.($4+1)/e' pubspec.yaml

# Commit and tag this change.
version=`grep 'version: ' pubspec.yaml | sed 's/version: //'`
git commit -m "Bump version to $version" pubspec.yaml
#git tag $version
#flutter build apk  --flavor dev --target-platform android-arm64 --release --tree-shake-icons --shrink  -t lib/main.dart

flutter build apk  --flavor dev --target-platform android-arm,android-arm64 --release -t lib/main.dart