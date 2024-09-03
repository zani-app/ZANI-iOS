//
//  ErrorResponse.swift
//  CoreKit
//
//  Created by 정도현 on 9/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Foundation

public struct ErrorResponse: Codable {
  public let code: Int
  public let message: String
}
