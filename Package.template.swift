// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "__VIDEOKIT_VERSION__"
let build = "__COMMIT_HASH__"

let package = Package(
    name: "VideoKit",
    platforms: [
        // Add support for all platforms starting from a specific version.
        //.macOS(.v10_15),
        .iOS(.v11),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "VideoKitCore",
            targets: ["VideoKitCoreWrapper"]
        ),
        .library(
            name: "VideoKitPlayer",
            targets: ["VideoKitPlayer"]
        ),
        .library(
            name: "VideoKitRecorder",
            targets: ["VideoKitRecorder"]
        ),
        .library(
            name: "VideoKitLive",
            targets: ["VideoKitLiveWrapper"]
        ),
    ],
    dependencies: [],
    targets: [
        // swift package compute-checksum VideoKit-1.0.3.zip
        .binaryTarget(
            name: "VideoKitCore",
            url: "https://cdn.video.io/ios/\(version)/VideoKitCore.xcframework.zip?ignoreCache=1&build=\(build)",
            checksum: "__CORE_CHECKSUM__"
        ),
        .target(
              name: "VideoKitCoreWrapper",
              dependencies: [
                .target(name: "VideoKitCore"),
              ],
              path: "VideoKitCoreWrapper",
              linkerSettings: [
                .linkedLibrary("z"),
              ]
        ),
        .binaryTarget(
            name: "VideoKitPlayer",
            url: "https://cdn.video.io/ios/\(version)/VideoKitPlayer.xcframework.zip?ignoreCache=1&build=\(build)",
            checksum: "__PLAYER_CHECKSUM__"
        ),
        .binaryTarget(
            name: "VideoKitRecorder",
            url: "https://cdn.video.io/ios/\(version)/VideoKitRecorder.xcframework.zip?ignoreCache=1&build=\(build)",
            checksum: "__RECORDER_CHECKSUM__"
        ),
        .binaryTarget(
            name: "VideoKitLive",
            url: "https://cdn.video.io/ios/\(version)/VideoKitLive.xcframework.zip?ignoreCache=1&build=\(build)",
            checksum: "__LIVE_CHECKSUM__"
        ),
        .target(
            name: "VideoKitLiveWrapper",
            dependencies: [
                .target(name: "VideoKitLive"),
            ],
            path: "VideoKitLiveWrapper"
        ),
    ]
)
