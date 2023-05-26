#/bin/bash

if [ "$1" = "" ]; then
  echo "Provide the version as first parameter. (e.g. 1.0.5)"
  echo ""
  exit 1
fi

VERSION="${1}"

curl -O "https://cdn.video.io/ios/$VERSION/VideoKitCore.xcframework.zip"
curl -O "https://cdn.video.io/ios/$VERSION/VideoKitRecorder.xcframework.zip"
curl -O "https://cdn.video.io/ios/$VERSION/VideoKitPlayer.xcframework.zip"

VK_CORE="`swift package compute-checksum VideoKitCore.xcframework.zip`"
VK_RECORDER="`swift package compute-checksum VideoKitRecorder.xcframework.zip`"
VK_PLAYER="`swift package compute-checksum VideoKitPlayer.xcframework.zip`"

echo "Core: $VK_CORE"
echo "Recorder: $VK_RECORDER"
echo "Player: $VK_PLAYER"

cp Package.template.swift Package.swift
sed -i '' "s/__VIDEOKIT_VERSION__/${VERSION}/g" Package.swift
sed -i '' "s/__CORE_CHECKSUM__/${VK_CORE}/g" Package.swift
sed -i '' "s/__PLAYER_CHECKSUM__/${VK_PLAYER}/g" Package.swift
sed -i '' "s/__RECORDER_CHECKSUM__/${VK_RECORDER}/g" Package.swift

echo "Done. Release using the following command: git commit Package.swift -m \"checksum update\" && git tag $1 && git push --tags"
