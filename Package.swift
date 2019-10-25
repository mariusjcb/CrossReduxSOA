// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CrossReduxSOA",
    platforms: [
        .macOS(.v10_10), .iOS(.v12), .tvOS(.v10), .watchOS(.v4)
    ],
    products: [
        .library(name: "Common", targets: ["Common"]),
        .library(name: "Redux", targets: ["Redux"]),
        .library(name: "ApiModule", targets: ["ApiModule"]),
        
        /*.library(name: "CrossReduxSOA.Models", targets: ["CrossReduxSOA.Models"]),
        .library(name: "CrossReduxSOA.ApiModule", targets: ["CrossReduxSOA.ApiModule"]),
        .library(name: "CrossReduxSOA.Reducers", targets: ["CrossReduxSOA.Reducers"]),
        .library(name: "CrossReduxSOA.ReduxStores", targets: ["CrossReduxSOA.ReduxStores"]),
        .executable(name: "CrossReduxSOA.UI", targets: ["CrossReduxSOA.UI"]),*/
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.0.0"),
        .package(url: "https://github.com/RxSwiftCommunity/RxAlamofire.git", from: "5.0.0")
    ],
    targets: [
        .target(name: "Common", dependencies: [], path: "./Common/Common/"),
        .target(name: "Redux", dependencies: ["Common"], path: "./ReduxModule/Redux/"),
        .target(name: "ApiModule", dependencies: ["Redux", "RxAlamofire"], path: "./ApiModule/ApiModule/"),
        
        /*.target(name: "CrossReduxSOA.Models", dependencies: ["Common", "Redux"],
                path: "./Example/CrossReduxSOA.Models/CrossReduxSOA.Models/"),
        .target(name: "CrossReduxSOA.ApiModule", dependencies: ["RxAlamofire", "CrossReduxSOA.Models"],
                path: "./Example/CrossReduxSOA.ApiModule/CrossReduxSOA.ApiModule/"),
        .target(name: "CrossReduxSOA.Reducers", dependencies: ["Redux", "ApiModule"],
                path: "./Example/CrossReduxSOA.Reducers/CrossReduxSOA.Reducers/"),
        .target(name: "CrossReduxSOA.ReduxStores", dependencies: ["Common", "Redux", "CrossReduxSOA.Models", "CrossReduxSOA.Reducers"],
                path: "./Example/CrossReduxSOA.ReduxStores/CrossReduxSOA.ReduxStores/"),
        .target(name: "CrossReduxSOA.UI", dependencies: ["Common", "Redux", "ApiModule", "CrossReduxSOA.Models", "CrossReduxSOA.ApiModule", "CrossReduxSOA.Reducers", "CrossReduxSOA.ReduxStores"],
                path: "./Example/CrossReduxSOA.UI/CrossReduxSOA.UI/"),*/
        
        .target(
            name: "CrossReduxSOA",
            dependencies: []),
        .testTarget(
            name: "CrossReduxSOATests",
            dependencies: ["CrossReduxSOA"]),
    ],
    swiftLanguageVersions: [.v5]
)
