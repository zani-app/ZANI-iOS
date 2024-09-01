import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
  name: ModulePaths.Feature.BaseFeature.rawValue,
  targets: [
    .implements(module: .feature(.BaseFeature), product: .framework, dependencies: [
      .userInterface(target: .DesignSystem),
      .domain(target: .BaseDomain)
    ]),
    .tests(module: .feature(.BaseFeature), dependencies: [
      .feature(target: .BaseFeature)
    ])
  ]
)
