//
//  BaseEntity.swift
//  CoreKit
//
//  Created by 정도현 on 9/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Foundation

public struct BaseEntity<T> {
  public let success: Bool
  public let data: T
  public let error: ErrorResponse?
  
  enum CodingKeys: String, CodingKey {
    case success
    case data
    case error
  }
}

extension BaseEntity: Decodable where T: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    success = try container.decode(Bool.self, forKey: .success)
    data = try container.decode(T.self, forKey: .data)
    error = try? container.decode(ErrorResponse.self, forKey: .error)
  }
}
