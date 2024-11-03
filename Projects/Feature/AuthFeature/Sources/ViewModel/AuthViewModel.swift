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

import KakaoSDKAuth
import KakaoSDKUser

import AuthFeatureInterface

public class AuthViewModel {
  
  public struct Input {
    let viewDidAppear: AnyPublisher<Void, Never>
    let tappedKakaoLoginButton: AnyPublisher<Void, Never>
    let tappedAppleLoginButton: AnyPublisher<Void, Never>
    let tappedEmailLoginButton: AnyPublisher<Void, Never>
    let tappedEmailSignUp: AnyPublisher<Void, Never>
  }
  
  public struct Output {
    
  }
  
  private var cancellables = Set<AnyCancellable>()
  
  public func transform(from input: Input) -> Output {
    let output = Output()
    
    input.tappedKakaoLoginButton
      .sink { _ in
        print("test action")
      }
      .store(in: &self.cancellables)
    
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
