//
//  Coordinator.swift
//  BaseFeature
//
//  Created by 정도현 on 11/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Foundation

public protocol Coordinator: AnyObject {
  var childCoordinators: [Coordinator] { get set }
  func start()
}
