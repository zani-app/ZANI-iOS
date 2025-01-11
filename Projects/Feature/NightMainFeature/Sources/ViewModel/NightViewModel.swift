//
//  NightViewModel.swift
//  NightMainFeatureInterface
//
//  Created by 정도현 on 11/25/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Combine

import BaseDomain
import CoreKit

import KakaoSDKUser

public class NightViewModel {
  
  enum Input {
    case tappedEnterButton
  }
  
  enum Output {
    
  }
  
  private let output: PassthroughSubject<Output, Never> = .init()
  
  private var cancelBag = CancelBag()
  
  func transform(from input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
    input.sink { [weak self] event in
      switch event {
      case .tappedEnterButton:
        print("HI")
      }
    }
    .store(in: cancelBag)
    
    return output.eraseToAnyPublisher()
  }
}
