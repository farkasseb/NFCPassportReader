// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "NFCPassportReader",
    platforms: [.iOS("15.0")],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "NFCPassportReader",
            type: .dynamic,
            targets: ["NFCPassportReader"]),
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/OpenSSL.git", .upToNextMinor(from: "1.1.2200"))

    ],
    targets: [
        .target(
            name: "NFCPassportReader",
            dependencies: ["OpenSSL"],
            swiftSettings: [
                .unsafeFlags([
                    "-emit-module-interface",
                    "-enable-library-evolution"
                ])
            ]
        ),
    ]
)

