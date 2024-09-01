import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.NightMainFeature.rawValue,
    targets: [
        .interface(module: .feature(.NightMainFeature), dependencies: [
          .feature(target: .BaseFeature)
        ]),
        .implements(module: .feature(.NightMainFeature), dependencies: [
            .feature(target: .NightMainFeature, type: .interface)
        ]),
        .tests(module: .feature(.NightMainFeature), dependencies: [
            .feature(target: .NightMainFeature)
        ]),
        .demo(module: .feature(.NightMainFeature), dependencies: [
            .feature(target: .NightMainFeature)
        ])
    ]
)
