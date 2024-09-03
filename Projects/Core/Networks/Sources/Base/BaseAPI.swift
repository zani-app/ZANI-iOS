//
//  BaseAPI.swift
//  Networks
//
//  Created by 정도현 on 9/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import CoreKit

import Alamofire
import Moya
import Foundation

public enum APIType {
  // MARK: API TYPES
}

public protocol BaseAPI: TargetType {
  static var apiType: APIType { get set }
}

extension BaseAPI {
  public var baseURL: URL {
    var base = Config.baseURL
    
    switch Self.apiType {
      // MARK: API TYPE ADDRESS
    }
    
    guard let url = URL(string: base) else {
      fatalError("baseURL could not be configured")
    }
    
    return url
  }
  
  public var headers: [String: String]? {
    return HeaderType.jsonWithToken.value
  }
  
  public var validationType: ValidationType {
    return .customCodes(Array(200..<600).filter { $0 != 401 })
  }
}

public enum HeaderType {
  case json
  case jsonWithToken
  case multipartWithToken
  
  public var value: [String: String] {
    switch self {
    case .json:
      return ["Content-Type": "application/json"]
      
    case .jsonWithToken:
      return [
        "Content-Type": "application/json",
        "Authorization": UserDefaultsList.Auth.accessToken ?? ""
      ]
      
    case .multipartWithToken:
      return [
        "Content-Type": "multipart/form-data",
        "Authorization": UserDefaultsList.Auth.accessToken ?? ""
      ]
    }
  }
}
