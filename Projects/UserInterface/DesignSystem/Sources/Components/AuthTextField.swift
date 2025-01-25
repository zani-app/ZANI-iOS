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

public enum AuthTextFieldType {
  case nickname
  
  public var placeHolder: String {
    switch self {
    case .nickname: "닉네임을 입력해주세요"
    }
  }
  
  public var maxLength: Int {
    switch self {
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
  
  // MARK: UI Component
  private let textField = PastBlockedTextField()
  
  public var type: AuthTextFieldType!
  private var textFieldState = CurrentValueSubject<AuthTextFieldState, Never>(.normal)
  
  public var text: String {
    get {
      return textField.text ?? ""
    }
  }
  
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
      }
      .store(in: cancelBag)
    
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
    textField.backgroundColor = .clear
    textField.textColor = .white
    textField.tintColor = DesignSystemAsset.mainYellow.color
    textField.attributedPlaceholder = NSAttributedString(
      string: self.type.placeHolder,
      attributes: [NSAttributedString.Key.foregroundColor : DesignSystemAsset.mainGray.color]
    )
    textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18.5, height: 0))
    textField.leftViewMode = .always
    textField.layer.cornerRadius = 24
    textField.layer.borderWidth = 1.0
    textField.backgroundColor = .black
    textField.font = UIFont.ZANIFontType.body1.font
    textField.returnKeyType = .done
  }
  
  private func setLayout() {
    self.addSubview(textField)
    self.configureTitleLabel()
  }
  
  private func configureTitleLabel() {
    textField.snp.makeConstraints { make in
      make.leading.trailing.top.bottom.equalToSuperview()
      make.height.equalTo(48)
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
