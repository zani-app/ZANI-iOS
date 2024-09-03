//
//  NetworkResult.swift
//  CoreKit
//
//  Created by 정도현 on 9/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Foundation

public enum NetworkResult<T> {
  case success(T)
  case failure(NetworkError)
}
