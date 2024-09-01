import ProjectDescription

public extension TargetDependency {
  struct SPM {}
}

public extension TargetDependency.SPM {
  static let Alamofire = TargetDependency.external(name: "Alamofire")
  static let Moya = TargetDependency.external(name: "Moya")
  static let Swinject = TargetDependency.external(name: "Swinject")
  static let SnapKit = TargetDependency.external(name: "SnapKit")
}

public extension Package {
}
