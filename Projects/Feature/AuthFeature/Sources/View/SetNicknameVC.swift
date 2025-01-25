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
  
  public var viewModel: AuthNicknameViewModel!
  
  private let input: PassthroughSubject<AuthNicknameViewModel.Input, Never> = .init()
  private var cancelBag = CancelBag()
  
  private lazy var titleImage: UIImageView = {
    let imageView: UIImageView = UIImageView(image: DesignSystemAsset.doubleMoonIcon.image)
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private lazy var navigationBar: NavigationBar = {
    let navigationBar = NavigationBar(
      leftIcon: UIImage(systemName: "chevron.left"),
      title: "회원가입"
    )
    
    navigationBar.setBackgroundColor(color: .black)
    
    return navigationBar
  }()
  
  private lazy var titleLabel: UILabel = {
    let title = UILabel()
    title.attributedText = UIFont.zaniAttributedString(
      text: "자니에서 사용할\n닉네임을 입력해주세요",
      fontType: .title1
    )
    title.numberOfLines = 2
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
    button.setHeight(height: 48)
    return button
  }()
  
  private var nextButtonBottomConstraint: Constraint?
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.bind()
    self.hideKeyboardWhenTappedAround()
    self.setUI()
    self.setLayout()
    self.setupKeyboardObservers()
  }
}

private extension SetNicknameVC {
  func setUI() {
    self.view.backgroundColor = DesignSystemAsset.main1.color
    
    titleImage.snp.makeConstraints { make in
      make.width.equalTo(55)
      make.height.equalTo(43)
    }
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.view.bounds
    
    let backgroundColors: [CGColor] = [
      UIColor.black.cgColor,
      .init(red: 0, green: 208/255, blue: 1, alpha: 1)
    ]
    gradientLayer.colors = backgroundColors
    gradientLayer.locations = [0.55]
  
    self.view.layer.addSublayer(gradientLayer)
  }
  
  func setLayout() {
    self.view.addSubview(titleImage)
    self.view.addSubview(navigationBar)
    self.view.addSubview(titleLabel)
    self.view.addSubview(nicknameTextField)
    self.view.addSubview(nextButton)
    
    navigationBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.trailing.equalToSuperview()
    }
    
    titleImage.snp.makeConstraints { make in
      make.top.equalTo(navigationBar.snp.bottom).offset(38)
      make.leading.equalToSuperview().inset(35)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(titleImage.snp.bottom).offset(10)
      make.leading.equalToSuperview().inset(38)
    }
    
    nicknameTextField.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(28)
      make.leading.trailing.equalToSuperview().inset(35)
      make.centerX.equalTo(self.view)
    }
    
    nextButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      self.nextButtonBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8).constraint
      make.centerX.equalTo(self.view)
    }
  }
}

private extension SetNicknameVC {
  func bind() {
    let output = viewModel.transform(from: input.eraseToAnyPublisher())
    
    buttonPublisher(for: nextButton)
      .sink(receiveValue: { [weak self] in
        self?.input.send(.textInput(nickname: self?.nicknameTextField.text ?? ""))
      })
      .store(in: cancelBag)
    
    navigationBar.leftButtonTap
      .compactMap { _ in () }
      .receive(on: RunLoop.main)
      .sink(receiveValue: { [weak self] in
        self?.input.send(.tappedBackButton)
      })
      .store(in: cancelBag)
    
    nicknameTextField.textChanged
      .receive(on: RunLoop.main)
      .sink { [weak self] text in
        guard let self = self else { return }
        guard let text = text else { return }
        
        self.nextButton.setEnabled(!text.isEmpty)
      }
      .store(in: cancelBag)
  }
  
  private func buttonPublisher(for button: UIButton) -> AnyPublisher<Void, Never> {
    button.publisher(for: .touchUpInside)
      .map { _ in () }
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
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
