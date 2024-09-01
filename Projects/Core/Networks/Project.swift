import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
  name: ModulePaths.Core.Networks.rawValue,
  targets: [
    .implements(module: .core(.Networks), dependencies: [
      .core(target: .CoreKit)
    ])
  ]
)
