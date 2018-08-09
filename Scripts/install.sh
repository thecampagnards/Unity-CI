#! /bin/bash

BASE_URL=http://netstorage.unity3d.com/unity
WORKING_DIR=$(pwd)
# Get version from project
VERSION=$(cut -d' ' -f2 < "$WORKING_DIR"/ProjectSettings/ProjectVersion.txt)
echo $VERSION
# Find hash on the html of the unity archives
tmp=$(curl -s -i -X GET https://unity3d.com/fr/get-unity/download/archive)
re="https:\/\/netstorage\.unity3d\.com\/unity\/(.+?)\/MacEditorInstaller\/Unity-$VERSION\.pkg"

echo $tmp
echo $re

if [[ $tmp =~ $re ]]; then
    HASH=${BASH_REMATCH[1]}
else
    echo "No version found"
    exit 1
fi

echo "version:$VERSION - hash:$HASH"

download() {
  package=$1
  url="$BASE_URL/$HASH/$package"

  echo "Downloading from $url: "
  curl -o $(basename "$package") "$url"
}

install() {
  package=$1
  download "$package"

  echo "Installing "$(basename "$package")
  sudo installer -dumplog -package $(basename "$package") -target /
}

# See $BASE_URL/$HASH/unity-$VERSION-$PLATFORM.ini for complete list
# of available packages, where PLATFORM is `osx` or `win`

install "MacEditorInstaller/Unity-$VERSION.pkg"
install "MacEditorTargetInstaller/UnitySetup-Windows-Support-for-Editor-$VERSION.pkg"
install "MacEditorTargetInstaller/UnitySetup-Mac-Support-for-Editor-$VERSION.pkg"
install "MacEditorTargetInstaller/UnitySetup-Linux-Support-for-Editor-$VERSION.pkg"
