#/bin/bash

if [ "$1" = "" ]; then
  echo "Provide the path to the VideoKit XCFramework packages as first parameter."
  echo ""
  exit 1
fi

if [ "$2" = "" ]; then
  echo "Provide the version as second parameter. (e.g. 1.0.5)"
  echo ""
  exit 1
fi

VERSION="${2}"
VK_CORE="`swift package compute-checksum \"$1/VideoKitCore.xcframework.zip\"`"
VK_RECORDER="`swift package compute-checksum \"$1/VideoKitRecorder.xcframework.zip\"`"
VK_PLAYER="`swift package compute-checksum \"$1/VideoKitPlayer.xcframework.zip\"`"
VK_LIVE="`swift package compute-checksum \"$1/VideoKitLive.xcframework.zip\"`"

echo "Core: $VK_CORE"
echo "Recorder: $VK_RECORDER"
echo "Player: $VK_PLAYER"
echo "Live: $VK_LIVE"

cp Package.template.swift Package.swift
sed -i '' "s/__VIDEOKIT_VERSION__/${VERSION}/g" Package.swift
sed -i '' "s/__CORE_CHECKSUM__/${VK_CORE}/g" Package.swift
sed -i '' "s/__PLAYER_CHECKSUM__/${VK_PLAYER}/g" Package.swift
sed -i '' "s/__RECORDER_CHECKSUM__/${VK_RECORDER}/g" Package.swift
sed -i '' "s/__LIVE_CHECKSUM__/${VK_LIVE}/g" Package.swift

echo "Done. Release using the following command: git commit Package.swift -m \"checksum update\" && git tag $2 && git push --tags"
