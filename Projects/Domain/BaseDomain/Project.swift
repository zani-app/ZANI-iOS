import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
  name: ModulePaths.Domain.BaseDomain.rawValue,
  targets: [
    .implements(module: .domain(.BaseDomain), product: .framework, dependencies: [
      .core(target: .CoreKit)
    ]),
    .tests(module: .domain(.BaseDomain), dependencies: [
      .domain(target: .BaseDomain)
    ])
  ]
)
