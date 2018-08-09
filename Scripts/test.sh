#!/bin/sh

echo "Attempting to test"
/Applications/Unity/Unity.app/Contents/MacOS/Unity \
  -runTests \
  -projectPath "$(pwd)" \
  -testResults "$(pwd)"/results.xml \
  -testPlatform editmode

echo 'Results from tests'
cat "$(pwd)"/results.xml