// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// 各ターゲットで利用する際に補完が効くためタイポ防止
private extension PackageDescription.Target.Dependency {
    static let nimble: Self = .product(name: "Nimble", package: "Nimble")
    static let quick: Self = .product(name: "Quick", package: "Quick")
    static let algorithms: Self = .product(name: "Algorithms", package: "swift-algorithms")
    static let sdWebImageSwiftUI: Self = .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI")
    static let sdWebImage: Self = .product(name: "SDWebImage", package: "SDWebImage")
    static let realm: Self = .product(name: "Realm", package: "realm-swift")
    static let realmSwift: Self = .product(name: "RealmSwift", package: "realm-swift")
    // static let firebase: Self = .product(name: "Firebase", package: "firebase-ios-sdk")
    static let firebaseFirestore: Self = .product(name: "FirebaseFirestore", package: "firebase-ios-sdk")

    // local module
    static let core: Self = .target(name: "Core")
    static let infra: Self = .target(name: "Infra")
    static let presentation: Self = .target(name: "Presentation")
}

let package = Package(
    name: "Packages",
    platforms: [.iOS("16.0")],
    products: [
        .library(
            name: "PresentationLib",
            targets: ["Presentation"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", exact: "13.2.1"),
        .package(url: "https://github.com/Quick/Quick.git", exact: "7.4.1"),
        .package(url: "https://github.com/realm/realm-swift.git", exact: "10.49.1"),
        .package(url: "https://github.com/apple/swift-algorithms.git", exact: "1.2.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", exact: "3.0.1"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", exact: "10.24.0")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .realm,
                .realmSwift
            ]
        ),
        .target(
            name: "Infra",
            dependencies: [
                .core,
                .realm,
                .realmSwift
            ]
        ),
        .target(
            name: "Presentation",
            dependencies: [
                .infra,
                .algorithms,
                .sdWebImageSwiftUI,
                // .firebase,
                .firebaseFirestore,
                .realmSwift,
                .realm
            ],
            resources: [.process("UICore/Resources")]
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: [
                .core,
                .nimble,
                .quick
            ]
        ),
        .testTarget(
            name: "InfraTests",
            dependencies: [
                .infra,
                .nimble,
                .quick
            ]
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: [
                .presentation,
                .nimble,
                .quick
            ]
        )
    ]
)
