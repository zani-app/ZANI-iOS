//
//  CancelBag.swift
//  CoreKit
//
//  Created by 정도현 on 9/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Combine

open class CancelBag {
  public fileprivate(set)var subsc = Set<AnyCancellable>()
  
  public init() { }
  
  public func cancel() {
    subsc.forEach { $0.cancel() }
    subsc.removeAll()
  }
}

extension AnyCancellable {
  public func store(in cancelBag: CancelBag) {
    cancelBag.subsc.insert(self)
  }
}
