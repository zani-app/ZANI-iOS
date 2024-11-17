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
  
  public struct Input {
    let tappedKakaoLoginButton: AnyPublisher<Void, Never>?
    let tappedAppleLoginButton: AnyPublisher<Void, Never>?
    let tappedEmailLoginButton: AnyPublisher<Void, Never>?
    let tappedNicknameCheckButton: AnyPublisher<Void, Never>?
    let tappedSignUpSuccessButton: AnyPublisher<Void, Never>?
    let tappedBackButton: AnyPublisher<Void, Never>?
  }
  
  public struct Output {
    
  }
  
  weak var delegate: AuthViewModelDelegate?
  
  private var cancelBag = CancelBag()
  
  public func transform(from input: Input) -> Output {
    let output = Output()
    
    input.tappedKakaoLoginButton?
      .sink { _ in
        print("kakao action")
        self.delegate?.goToNickname()
      }
      .store(in: self.cancelBag)
    
    input.tappedAppleLoginButton?
      .sink { _ in
        print("apple action")
      }
      .store(in: self.cancelBag)
    
    input.tappedEmailLoginButton?
      .sink { _ in
        print("email action")
      }
      .store(in: self.cancelBag)
    
    input.tappedNicknameCheckButton?
      .sink { _ in
        print("Nickname Check action")
        self.delegate?.goToDone()
      }
      .store(in: self.cancelBag)
    
    input.tappedBackButton?
      .sink { _ in
        print("tapped Back Button")
        self.delegate?.goBack()
      }
      .store(in: self.cancelBag)
    
    return output
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
