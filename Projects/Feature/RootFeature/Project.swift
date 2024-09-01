import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
  name: ModulePaths.Feature.RootFeature.rawValue,
  targets: [
    .implements(module: .feature(.RootFeature), dependencies: [
      .feature(target: .AuthFeature),
      .feature(target: .NightMainFeature),
      .feature(target: .ChattingFeature),
      .feature(target: .TimelineFeature),
      .feature(target: .CommunityFeature),
      .feature(target: .ProfileFeature)
    ]),
    .demo(module: .feature(.RootFeature), dependencies: [
      .feature(target: .RootFeature)
    ])
  ]
)
