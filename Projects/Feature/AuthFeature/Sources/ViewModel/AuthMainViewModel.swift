//
//  AuthViewModel.swift
//  AuthFeatureInterface
//
//  Created by 정도현 on 11/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Combine

import BaseDomain
import CoreKit

import KakaoSDKUser

public class AuthMainViewModel {
  
  enum Input {
    case tappedKakaoLoginButton
    case tappedAppleLoginButton
    case tappedGoogleLoginButton
  }
  
  enum Output {
    case loginFailure(error: Error)
  }
  
  private let output: PassthroughSubject<Output, Never> = .init()
  
  weak var delegate: AuthViewModelDelegate?
  
  private var cancelBag = CancelBag()
  
  func transform(from input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
    input.sink { [weak self] event in
      switch event {
      case .tappedKakaoLoginButton:
        print("Kakao login")
        self?.delegate?.goToNickname()
        
      case .tappedAppleLoginButton:
        print("Apple login")
        self?.delegate?.goToNickname()
        
      case .tappedGoogleLoginButton:
        print("Google login")
        self?.delegate?.goToNickname()
      }
    }
    .store(in: cancelBag)
    
    return output.eraseToAnyPublisher()
  }
}

private extension AuthMainViewModel {
  func handleKakaoLogin() {
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        if let oauthToken = oauthToken {
          // self.signUpUserWithSocialLogin(loginPath: .kakao, token: oauthToken)
        } else {
          print("Kakao Login Error")
        }
        
        if let error = error {
          print(error.localizedDescription)
        }
      }
    } else {
      UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
        if let oauthToken = oauthToken {
          // self.signUpUserWithSocialLogin(loginPath: .kakao, token: oauthToken)
        } else {
          print("Kakao Login Error")
        }
        
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
}
