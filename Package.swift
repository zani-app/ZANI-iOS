// swift-tools-version:5.7
import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers

let packageSetting = PackageSettings(
  productTypes: [
    "Alamofire": .staticFramework,
    "Moya": .staticFramework
  ],
  baseSettings: .settings(
    configurations: [
      .debug(name: .dev),
      .debug(name: .stage),
      .release(name: .prod)
    ]
  )
)
#endif

let package = Package(
  name: "ZANI",
  dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.1"),
    .package(url: "https://github.com/Moya/Moya.git", exact: "15.0.3"),
    .package(url: "https://github.com/Swinject/Swinject.git", exact: "2.9.1"),
    .package(url: "https://github.com/SnapKit/SnapKit.git", exact: "5.7.1"),
    .package(url: "https://github.com/kakao/kakao-ios-sdk.git", branch: "master")
  ]
)
