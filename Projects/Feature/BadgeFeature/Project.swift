import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.BadgeFeature.rawValue,
    targets: [
        .interface(module: .feature(.BadgeFeature), dependencies: [
          .feature(target: .BaseFeature)
        ]),
        .implements(module: .feature(.BadgeFeature), dependencies: [
            .feature(target: .BadgeFeature, type: .interface)
        ]),
        .tests(module: .feature(.BadgeFeature), dependencies: [
            .feature(target: .BadgeFeature)
        ]),
        .demo(module: .feature(.BadgeFeature), dependencies: [
            .feature(target: .BadgeFeature)
        ])
    ]
)
