import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
  name: ModulePaths.Shared.Networks.rawValue,
  targets: [
    .implements(module: .shared(.Networks), dependencies: [
      .core(target: .CoreKit)
    ])
  ]
)
