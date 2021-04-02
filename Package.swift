// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "1.0.12"
let build = "e5c449f"

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
            checksum: "db21b9ce5aa61f5605aa2f9e6dc08b511e6104869ae410b1842b557a7e0e2756"
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
            checksum: "8424bebe34d9c333e31489cefc2d3e20d7d1914dd01962babf0769084def14d6"
        ),
        .binaryTarget(
            name: "VideoKitRecorder",
            url: "https://cdn.video.io/ios/\(version)/VideoKitRecorder.xcframework.zip?ignoreCache=1&build=\(build)",
            checksum: "d8c35952c1ab26c6abb42b632ddad2eb66da6a6bdfc9ea3def510b3fbfdec0e4"
        ),
        .binaryTarget(
            name: "VideoKitLive",
            url: "https://cdn.video.io/ios/\(version)/VideoKitLive.xcframework.zip?ignoreCache=1&build=\(build)",
            checksum: "608f8d6ef57d6a3695342513521393c8876db87eae13e0d229d0ccc4f611a0ae"
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
