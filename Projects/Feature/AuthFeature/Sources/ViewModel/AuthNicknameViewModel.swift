//
//  AuthNicknameViewModel.swift
//  AuthFeature
//
//  Created by 정도현 on 1/18/25.
//  Copyright © 2025 zani.com. All rights reserved.
//

import Combine

import BaseDomain
import CoreKit

public class AuthNicknameViewModel {
  
  enum Input {
    case textInput(nickname: String)
    case tappedBackButton
  }
  
  enum Output {
    case validate(nickname: String)
  }
  
  private let output: PassthroughSubject<Output, Never> = .init()
  
  weak var delegate: AuthViewModelDelegate?
  
  private var cancelBag = CancelBag()
  
  func transform(from input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
    input.sink { [weak self] event in
      switch event {
      case let .textInput(nickname):
        print("user nickname: \(nickname)")
        self?.output.send(.validate(nickname: nickname))
        self?.delegate?.goToDone()
        
      case .tappedBackButton:
        print("Move Backs")
        self?.delegate?.goBack()
      }
    }
    .store(in: cancelBag)
    
    return output.eraseToAnyPublisher()
  }
}

private extension AuthNicknameViewModel {
  
}
