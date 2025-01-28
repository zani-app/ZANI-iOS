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
  
  public var descriptionColor: UIColor? {
    switch self {
    case .confirm:
      return UIColor(cgColor: CGColor(red: 0, green: 216/255, blue: 123/255, alpha: 1))
    case .warning:
      return UIColor(cgColor: CGColor(red: 255/255, green: 100/255, blue: 100/255, alpha: 1))
    default:
      return nil
    }
  }
}

public class AuthTextField: UIView {
  
  private var cancelBag = CancelBag()
  
  // MARK: UI Component
  private let textFieldContainerView = UIView()
  private let textField = UITextField()
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.ZANIFontType.body1.font
    return label
  }()
  
  public var type: AuthTextFieldType!
  
  private var textFieldState = CurrentValueSubject<AuthTextFieldState, Never>(.normal)
  
  public var text: String {
    return textField.text ?? ""
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
  
  public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if action == #selector(UIResponderStandardEditActions.paste(_:)) {
      return false
    }
    
    return super.canPerformAction(action, withSender: sender)
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
        // textfield state -> textfield border color
        self?.textField.layer.borderColor = state.borderColor.cgColor
        
        // textfield state -> description label
        if state == .confirm || state == .warning {
          self?.descriptionLabel.isHidden = false
          self?.descriptionLabel.textColor = state.descriptionColor
        } else {
          self?.descriptionLabel.isHidden = true
        }
      }
      .store(in: cancelBag)
  }
  
  @discardableResult
  public func setDescriptionText(text: String) -> Self {
    self.descriptionLabel.text = text
    return self
  }
  
  @discardableResult
  public func setTextfieldState(state: AuthTextFieldState) -> Self {
    self.textFieldState.send(state)
    return self
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
    self.addSubview(textFieldContainerView)
    textFieldContainerView.addSubview(textField)
    textFieldContainerView.addSubview(descriptionLabel)
    
    self.configureTitleLabel()
  }
  
  private func configureTitleLabel() {
    textFieldContainerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    textField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalToSuperview()
      make.height.equalTo(48)
    }
    
    descriptionLabel.snp.makeConstraints { make in
      make.trailing.equalToSuperview()
      make.top.equalTo(textField.snp.bottom).offset(12)
      make.bottom.lessThanOrEqualToSuperview()
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
