// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftTomCrypt",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TomCrypt",
            targets: ["TomCrypt"]),
        .library(
            name: "TomMath",
            targets: ["TomMath"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TomCrypt",
            dependencies: ["TomMath"],
            path: ".",
            sources: ["libtomcrypt/src"],
            publicHeadersPath: "libtomcrypt_modulemap",
            cSettings: [
                .headerSearchPath("libtomcrypt/src/headers"),
                .headerSearchPath("libtommath"),
                .define("USE_LTM"),
                .define("LTM_DESC"),
                .define("LTC_NO_TEST")
            ]),
        .target(
            name: "TomMath",
            path: ".",
            exclude: [
                "libtommath/demo",
                "libtommath/doc",
                "libtommath/etc",
                "libtommath/logs",
                "libtommath/mtest",
                "libtommath/Package.swift"
            ],
            sources: ["libtommath"],
            publicHeadersPath: "libtommath_modulemap",
            cSettings: [
                .unsafeFlags(["-flto=thin"])  // for Dead Code Elimination
            ]),
        .testTarget(name: "TomCryptTests",
                    dependencies: ["TomCrypt"],
                    path: "Tests",
                    sources: ["TomCryptTests.swift"]
                   ),
        .testTarget(name: "TomMathTests",
                    dependencies: ["TomMath"],
                    path: "Tests",
                    sources: ["TomMathTests.swift"]
                   )
    ],
    cLanguageStandard: .gnu11,
    cxxLanguageStandard: .gnucxx14
)
