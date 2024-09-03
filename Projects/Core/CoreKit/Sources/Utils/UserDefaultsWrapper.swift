//
//  UserDefaultsWrapper.swift
//  CoreKit
//
//  Created by 정도현 on 9/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T> {
  private let key: String
  
  init(key: String) {
    self.key = key
  }
  
  var wrappedValue: T? {
    get {
      UserDefaults.standard.object(forKey: key) as? T
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: key)
    }
  }
}
