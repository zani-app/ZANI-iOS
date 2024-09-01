import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.CommunityFeature.rawValue,
    targets: [
        .interface(module: .feature(.CommunityFeature), dependencies: [
          .feature(target: .BaseFeature)
        ]),
        .implements(module: .feature(.CommunityFeature), dependencies: [
            .feature(target: .CommunityFeature, type: .interface)
        ]),
        .tests(module: .feature(.CommunityFeature), dependencies: [
            .feature(target: .CommunityFeature)
        ]),
        .demo(module: .feature(.CommunityFeature), dependencies: [
            .feature(target: .CommunityFeature)
        ])
    ]
)
