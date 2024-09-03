//
//  NetworkError.swift
//  CoreKit
//
//  Created by 정도현 on 9/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
  case invalidResponse
  case invalidData
  case requestFailed(error: Error)
  case decodingFailed
  case requestErr
  case serverError
  case unknown
}
