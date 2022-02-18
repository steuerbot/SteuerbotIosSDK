// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Steuerbot",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Steuerbot",
            targets: ["SwiftFramework", "hermes"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        // No depency path added
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        
        .binaryTarget(
            name: "SwiftFramework",
            url: "https://steuerbot-app-artifacts-nonprod.s3.eu-central-1.amazonaws.com/sdk/ios/1.0.3-SNAPSHOT/SwiftFramework.xcframework.zip",
            checksum: "ebc19f8149728161643fcb969755ec1b03e5576ffee59e6c66ff04d5c621a96f"
        ),
        .binaryTarget(
            name: "hermes",
            url: "https://steuerbot-app-artifacts-nonprod.s3.eu-central-1.amazonaws.com/sdk/ios/hermes/v0.66.3/hermes.xcframework.zip",
            checksum: "53a9b586848fb4529f86920756e6273435e1b5ef247d8311e1ae0ed444e38a66"
        ),
    ]
)
