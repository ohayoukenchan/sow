// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "BuildTools",
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.53.7"),
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.54.0"),
    ],
    targets: [.target(name: "BuildTools", path: "")]
)
