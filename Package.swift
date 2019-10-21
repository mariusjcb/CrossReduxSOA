// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CrossReduxSOA",
    products: [
        .library(name: "Common", targets: ["Common"]),
        .library(name: "Redux", targets: ["Redux"]),
        .library(name: "ApiModule", targets: ["ApiModule"]),
        
        .library(name: "CrossReduxSOA.Models", targets: ["CrossReduxSOA.Models"]),
        .library(name: "CrossReduxSOA.ApiModule", targets: ["CrossReduxSOA.ApiModule"]),
        .library(name: "CrossReduxSOA.Reducers", targets: ["CrossReduxSOA.Reducers"]),
        .library(name: "CrossReduxSOA.ReduxStores", targets: ["CrossReduxSOA.ReduxStores"]),
        .library(name: "CrossReduxSOA.UI", targets: ["CrossReduxSOA.UI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.0.0"),
        .package(url: "https://github.com/RxSwiftCommunity/RxAlamofire.git", from: "5.0.0")
    ],
    targets: [
        .target(name: "Common", dependencies: [], path: "./Common/Common/"),
        .target(name: "Redux", dependencies: ["Common"], path: "./Redux/Redux/"),
        .target(name: "ApiModule", dependencies: ["Redux", "RxAlamofire"], path: "./ApiModule/ApiModule/"),
        .target(name: "CrossReduxSOA.Models", dependencies: ["Common", "Redux"],
                path: "./CrossReduxSOA/CrossReduxSOA.Models/CrossReduxSOA.Models/"),
        .target(name: "CrossReduxSOA.ApiModule", dependencies: ["CrossReduxSOA.Models"],
                path: "./CrossReduxSOA/CrossReduxSOA.ApiModule/CrossReduxSOA.ApiModule/"),
        .target(name: "CrossReduxSOA.Reducers", dependencies: ["Redux", "ApiModule"],
                path: "./CrossReduxSOA/CrossReduxSOA.Reducers/CrossReduxSOA.Reducers/"),
        .target(name: "CrossReduxSOA.ReduxStores", dependencies: ["Common", "Redux", "CrossReduxSOA.Models", "CrossReduxSOA.Reducers"],
                path: "./CrossReduxSOA/CrossReduxSOA.ReduxStores/CrossReduxSOA.ReduxStores/"),
        .target(name: "CrossReduxSOA.UI", dependencies: ["Common", "Redux", "ApiModule", "CrossReduxSOA.Models", "CrossReduxSOA.ApiModule", "CrossReduxSOA.Reducers", "CrossReduxSOA.ReduxStores"],
                path: "./CrossReduxSOA/CrossReduxSOA.UI/CrossReduxSOA.UI/"),
        
        .target(
            name: "CrossReduxSOA",
            dependencies: []),
        .testTarget(
            name: "CrossReduxSOATests",
            dependencies: ["CrossReduxSOA"]),
    ],
    swiftLanguageVersions: [.v5]
)
