//
//  AuthTextField.swift
//  DesignSystem
//
//  Created by 정도현 on 9/7/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import UIKit

import CoreKit

import Combine
import SnapKit

@frozen
public enum AuthTextFieldType {
  case email
  case password
  case passwordConfirm
  case nickname
  
  public var titleLabel: String {
    switch self {
    case .email: return "이메일"
    case .password: return "비밀번호"
    case .passwordConfirm: return "비밀번호 확인"
    case .nickname: return "닉네임"
    }
  }
  
  public var placeHolder: String {
    switch self {
    case .email: "abc@email.com"
    case .password: "영문, 숫자, 특수문자 포함 8자 이상"
    case .passwordConfirm: "비밀번호를 다시 한 번 입력해주세요"
    case .nickname: "닉네임을 입력해주세요"
    }
  }
  
  public var maxLength: Int {
    switch self {
    case .email: 50
    case .password: 30
    case .passwordConfirm: 30
    case .nickname: 8
    }
  }
}

@frozen
public enum AuthTextFieldState {
  case normal   // Default
  case editing  // 입력 중
  case warning  // 경고
  case confirm  // 성공
  
  public var borderColor: UIColor {
    switch self {
    case .normal, .confirm:
      return DesignSystemAsset.mainGray.color
    case .editing:
      return DesignSystemAsset.mainYellow.color
    case .warning:
      return DesignSystemAsset.errorRed.color
    }
  }
}

public class AuthTextField: UIView {
  
  private var cancelBag = CancelBag()
  
  // MARK: UI Components
  private var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.ZANIFontType.title2.font
    label.textColor = DesignSystemAsset.mainGray.color
    return label
  }()
  
  private let textFieldContainerView = UIView()
  private let textField = PastBlockedTextField()
  private let rightIcon = UIImage()
  private let alertLabel = UILabel()
  
  private var type: AuthTextFieldType!
  private var textFieldState = CurrentValueSubject<AuthTextFieldState, Never>(.normal)
  
  public var textChanged: AnyPublisher<String?, Never> {
    textField.publisher(for: .editingChanged)
      .map { _ in
        self.textField.text
      }
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
  
  public init(type: AuthTextFieldType) {
    super.init(frame: .zero)
    self.type = type
    self.setUI()
    self.setLayout()
    self.setDelegate()
    self.bindUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: Method
extension AuthTextField {
  
  private func bindUI() {
    textChanged
      .replaceNil(with: "")
      .sink { [weak self] text in
        guard let self = self else { return }
        
        if text.count >= self.type.maxLength {
          let index = text.index(text.startIndex, offsetBy: self.type.maxLength)
          let newString = text[text.startIndex..<index]
          self.textField.text = String(newString)
        }
        
        // Case Text Empty
        if text.isEmpty {
          
        }
      }.store(in: cancelBag)
    
    textFieldState
      .sink { [weak self] state in
        self?.textField.layer.borderColor = state.borderColor.cgColor
      }
      .store(in: cancelBag)
  }
}

// MARK: UI
extension AuthTextField {
  private func setDelegate() {
    self.textField.delegate = self
  }
  
  private func setUI() {
    titleLabel.text = self.type.titleLabel
    
    textField.backgroundColor = .clear
    textField.textColor = .white
    textField.tintColor = DesignSystemAsset.mainYellow.color
    textField.attributedPlaceholder = NSAttributedString(
      string: self.type.placeHolder,
      attributes: [NSAttributedString.Key.foregroundColor : DesignSystemAsset.mainGray.color]
    )
    textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
    textField.leftViewMode = .always
    textField.layer.cornerRadius = 8
    textField.layer.borderWidth = 1.0
    textField.backgroundColor = DesignSystemAsset.main1.color
    textField.font = UIFont.ZANIFontType.body1.font
    textField.returnKeyType = .done
    
    textFieldContainerView.backgroundColor = DesignSystemAsset.main1.color
  }
  
  private func setLayout() {
    self.addSubview(textFieldContainerView)
    self.configureTitleLabel()
  }
  
  private func configureTitleLabel() {
    self.snp.makeConstraints { make in
      make.height.equalTo(82)
    }
    
    self.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.leading.top.equalToSuperview()
    }
    
    textFieldContainerView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(15)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(48)
    }
    
    textFieldContainerView.addSubview(textField)
    textField.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.trailing.equalToSuperview()
    }
  }
}

extension AuthTextField: UITextFieldDelegate {
  
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    self.textFieldState.send(.editing)
  }
  
  public func textFieldDidEndEditing(_ textField: UITextField) {
    self.textFieldState.send(.confirm)
  }
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
