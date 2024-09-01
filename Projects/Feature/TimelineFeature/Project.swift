import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.TimelineFeature.rawValue,
    targets: [
        .interface(module: .feature(.TimelineFeature), dependencies: [
          .feature(target: .BaseFeature)
        ]),
        .implements(module: .feature(.TimelineFeature), dependencies: [
            .feature(target: .TimelineFeature, type: .interface)
        ]),
        .tests(module: .feature(.TimelineFeature), dependencies: [
            .feature(target: .TimelineFeature)
        ]),
        .demo(module: .feature(.TimelineFeature), dependencies: [
            .feature(target: .TimelineFeature)
        ])
    ]
)
