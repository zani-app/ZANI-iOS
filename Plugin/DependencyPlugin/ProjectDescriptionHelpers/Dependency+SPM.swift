import ProjectDescription

public extension TargetDependency {
  struct SPM {}
}

public extension TargetDependency.SPM {
  static let Alamofire = TargetDependency.external(name: "Alamofire")
  static let Moya = TargetDependency.external(name: "Moya")
  static let Swinject = TargetDependency.external(name: "Swinject")
  static let SnapKit = TargetDependency.external(name: "SnapKit")
  static let KakaoSDKUser = TargetDependency.external(name: "KakaoSDKUser")
  static let GoogleSignIn = TargetDependency.external(name: "GoogleSignIn")
}

public extension Package {
}
