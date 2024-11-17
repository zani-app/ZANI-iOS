//
//  Coordinator.swift
//  BaseFeature
//
//  Created by 정도현 on 11/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Foundation

public protocol Coordinator: AnyObject {
  var parentCoordinator: Coordinator? { get set }
  var childCoordinators: [Coordinator] { get set }
  
  func start()
  func finish()
  func addChildCoordinator(_ coordinator: Coordinator)
  func removeChildCoordinator(_ coordinator: Coordinator)
}

public extension Coordinator {
  func start() {
    preconditionFailure("오버라이드 필요")
  }
  
  func finish() {
    preconditionFailure("오버라이드 필요")
  }
  
  func addChildCoordinator(_ coordinator: Coordinator) {
    childCoordinators.append(coordinator)
  }
  
  func removeChildCoordinator(_ coordinator: Coordinator) {
    if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
      childCoordinators.remove(at: index)
    } else {
      print("coordinator 삭제 실패: \(coordinator). ")
    }
  }
}
