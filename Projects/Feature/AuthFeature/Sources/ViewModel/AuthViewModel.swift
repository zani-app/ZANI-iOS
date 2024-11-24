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

public class AuthViewModel {
  
  enum Input {
    case tappedKakaoLoginButton
    case tappedAppleLoginButton
    case tappedEmailLoginButton
    case tappedNicknameCheckButton
    case tappedSignUpSuccessButton
    case tappedBackButton
  }
  
  enum Output {
    
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
        
      case .tappedEmailLoginButton:
        print("Email login")
        
      case .tappedNicknameCheckButton:
        print("nickname check button")
        self?.delegate?.goToDone()
        
      case .tappedSignUpSuccessButton:
        print("signup success")
        
      case .tappedBackButton:
        print("move back")
        self?.delegate?.goBack()
      }
    }
    .store(in: cancelBag)
    
    return output.eraseToAnyPublisher()
  }
}

private extension AuthViewModel {
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
