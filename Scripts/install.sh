#! /bin/sh

BASE_URL=http://netstorage.unity3d.com/unity
# Get version from project
VERSION=`cat $(pwd)/ProjectSettings/ProjectVersion.txt | cut -d' ' -f2`
# Find hash on the html of the unity archives
tmp=$(curl -s -i -X GET https://unity3d.com/fr/get-unity/download/archive)
re="https:\/\/netstorage\.unity3d\.com\/unity\/(.+?)\/MacEditorInstaller\/Unity-$VERSION\.pkg"

if [[ $tmp =~ $re ]]; then
    HASH=${BASH_REMATCH[1]}
else
    echo "No version found"
    exit 1
fi

echo "version:$VERSION - hash:$HASH"

download() {
  file=$1
  url="$BASE_URL/$HASH/$package"

  echo "Downloading from $url: "
  curl -o `basename "$package"` "$url"
}

install() {
  package=$1
  download "$package"

  echo "Installing "`basename "$package"`
  sudo installer -dumplog -package `basename "$package"` -target /
}

# See $BASE_URL/$HASH/unity-$VERSION-$PLATFORM.ini for complete list
# of available packages, where PLATFORM is `osx` or `win`

install "MacEditorInstaller/Unity-$VERSION.pkg"
install "MacEditorTargetInstaller/UnitySetup-Windows-Support-for-Editor-$VERSION.pkg"
install "MacEditorTargetInstaller/UnitySetup-Mac-Support-for-Editor-$VERSION.pkg"
install "MacEditorTargetInstaller/UnitySetup-Linux-Support-for-Editor-$VERSION.pkg"
