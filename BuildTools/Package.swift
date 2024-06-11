// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "BuildTools",
    platforms: [.macOS(.v10_11)],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.53.10"),
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.55.1"),
    ],
    targets: [.target(name: "BuildTools", path: "")]
)
