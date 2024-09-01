import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.ChattingFeature.rawValue,
    targets: [
        .interface(module: .feature(.ChattingFeature), dependencies: [
          .feature(target: .BaseFeature)
        ]),
        .implements(module: .feature(.ChattingFeature), dependencies: [
            .feature(target: .ChattingFeature, type: .interface)
        ]),
        .tests(module: .feature(.ChattingFeature), dependencies: [
            .feature(target: .ChattingFeature)
        ]),
        .demo(module: .feature(.ChattingFeature), dependencies: [
            .feature(target: .ChattingFeature)
        ])
    ]
)
