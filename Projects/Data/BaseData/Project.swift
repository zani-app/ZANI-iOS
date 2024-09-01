import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
  name: ModulePaths.Data.BaseData.rawValue,
  targets: [
    .implements(module: .data(.BaseData), dependencies: [
      .core(target: .Networks),
      .domain(target: .BaseDomain)
    ])
  ]
)
