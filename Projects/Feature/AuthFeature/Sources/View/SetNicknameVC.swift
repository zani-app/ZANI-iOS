//
//  SetNicknameVC.swift
//  AuthFeatureInterface
//
//  Created by 정도현 on 11/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Combine
import UIKit

import BaseDomain
import CoreKit
import DesignSystem

import SnapKit

public class SetNicknameVC: UIViewController {
  
  public var viewModel: AuthViewModel = AuthViewModel()
  
  private lazy var titleLabel: UILabel = {
    let title = UILabel()
    title.text = "자니에서 사용할\n닉네임을 입력해주세요"
    title.numberOfLines = 2
    title.font = UIFont.ZANIFontType.head1.font
    title.textColor = .white
    title.textAlignment = .left
    return title
  }()
  
  private lazy var nicknameTextField: AuthTextField = {
    let textField = AuthTextField(type: .nickname)
    return textField
  }()
  
  private lazy var nextButton: CustomLargeButton = {
    let button = CustomLargeButton(title: "다음")
    button.setEnabled(false)
    return button
  }()
  
  private var nextButtonBottomConstraint: Constraint?
  private var cancelBag = CancelBag()
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModels()
    self.hideKeyboardWhenTappedAround()
    self.setUI()
    self.setLayout()
    self.setupKeyboardObservers()
  }
}

private extension SetNicknameVC {
  func setUI() {
    self.view.backgroundColor = DesignSystemAsset.main1.color
  }
  
  func setLayout() {
    self.view.addSubview(titleLabel)
    self.view.addSubview(nicknameTextField)
    self.view.addSubview(nextButton)
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(62)
      make.leading.equalToSuperview().offset(20)
    }
    
    nicknameTextField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.top.equalTo(titleLabel.snp.bottom).offset(54)
      make.centerX.equalTo(self.view)
    }
    
    nextButton.snp.makeConstraints { make in
      make.height.equalTo(48)
      make.leading.trailing.equalToSuperview().inset(20)
      self.nextButtonBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8).constraint
      make.centerX.equalTo(self.view)
    }
  }
}

private extension SetNicknameVC {
  func bindViewModels() {
    let tappedNicknameCheckButton = self.nextButton
      .publisher(for: .touchUpInside)
      .compactMap { _ in () }
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
    
    let input = AuthViewModel.Input(
      tappedKakaoLoginButton: nil,
      tappedAppleLoginButton: nil,
      tappedEmailLoginButton: nil,
      tappedNicknameCheckButton: tappedNicknameCheckButton,
      tappedSignUpSuccessButton: nil
    )
    
    nicknameTextField.textChanged
      .receive(on: RunLoop.main)
      .sink { [weak self] text in
        guard let self = self else { return }
        guard let text = text else { return }
        
        self.nextButton.setEnabled(!text.isEmpty)
      }
      .store(in: cancelBag)
    
    let _ = self.viewModel.transform(from: input)
  }
  
}

private extension SetNicknameVC {
  private func setupKeyboardObservers() {
    NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
      .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
      .sink { [weak self] keyboardFrame in
        guard let self = self else { return }
        let keyboardHeight = keyboardFrame.height
        self.nextButtonBottomConstraint?.update(offset: -keyboardHeight + 8)
        
        UIView.animate(withDuration: 0.3) {
          self.view.layoutIfNeeded()
        }
      }
      .store(in: cancelBag)
    
    NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
      .sink { [weak self] _ in
        guard let self = self else { return }
        self.nextButtonBottomConstraint?.update(offset: -8)
        
        UIView.animate(withDuration: 0.3) {
          self.view.layoutIfNeeded()
        }
      }
      .store(in: cancelBag)
  }
}