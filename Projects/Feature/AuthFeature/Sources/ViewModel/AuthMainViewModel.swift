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
import GoogleSignIn

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
      guard let self = self else { return }
      
      switch event {
      case .tappedKakaoLoginButton:
        self.kakaoSignIn()
        // self.delegate?.goToNickname()
        
      case .tappedAppleLoginButton:
        print("Apple login")
        self.delegate?.goToNickname()
        
      case .tappedGoogleLoginButton:
        self.googleSignIn()
        // self.delegate?.goToNickname()
      }
    }
    .store(in: cancelBag)
    
    return output.eraseToAnyPublisher()
  }
}

private extension AuthMainViewModel {
  func kakaoSignIn() {
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

private extension AuthMainViewModel {
  func googleSignIn() {
    
    let clientID = Config.getPropertyValue(.googleClientKey)
    
    let configuration = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = configuration
    
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
    guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
    
    GIDSignIn.sharedInstance.signIn(
      withPresenting: rootViewController,
      hint: nil,
      additionalScopes: [
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/userinfo.profile",
        "https://www.googleapis.com/auth/contacts",
        "https://www.googleapis.com/auth/contacts.readonly"
      ]
    ) { [unowned self] result, error in
      guard let result = result else { return }
      
      if let serverAuthCode = result.serverAuthCode {
        print(serverAuthCode)
      } else {
        print("🚨 warning - GIDSignIn ERROR")
      }
    }
  }
}
