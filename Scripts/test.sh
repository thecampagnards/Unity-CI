#!/bin/sh

echo "Attempting to test"
/Applications/Unity/Unity.app/Contents/MacOS/Unity \
  -batchmode \
  -nographics \
  -silent-crashes \
  -runTests \
  -projectPath "$(pwd)" \
  -testResults "$(pwd)"/results.xml \
  -testPlatform editmode
  -quit

echo 'Results from tests'
cat "$(pwd)"/results.xml