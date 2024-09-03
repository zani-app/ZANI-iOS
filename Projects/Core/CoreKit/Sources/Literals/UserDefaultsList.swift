//
//  UserDefaultsList.swift
//  CoreKit
//
//  Created by 정도현 on 9/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Foundation

public struct UserDefaultsList {
  public struct Auth {
    @UserDefaultsWrapper<String>(key: "accessToken") 
    public static var accessToken
    
    @UserDefaultsWrapper<String>(key: "refreshToken")
    public static var refreshToken
  }
}

extension UserDefaultsList {
  public static func clearData() {
    clearAuthData()
  }
  
  public static func clearAuthData() {
    UserDefaultsList.Auth.accessToken = nil
    UserDefaultsList.Auth.refreshToken = nil
  }
}
