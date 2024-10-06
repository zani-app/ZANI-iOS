//
//  CustomLargeButton.swift
//  DesignSystem
//
//  Created by 정도현 on 10/6/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import UIKit

import CoreKit

public class CustomLargeButton: UIButton {
  
  public init(title: String) {
    super.init(frame: .zero)
    self.setUI(title)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CustomLargeButton {
  
  @discardableResult
  public func setEnabled(_ isEnabled: Bool) -> Self {
    self.isEnabled = isEnabled
    self.updateButtonState()
    return self
  }
  
  @discardableResult
  public func changeTitle(title: String) -> Self {
    let string = UIFont.zaniAttributedString(text: title, fontType: .title2)
    self.setAttributedTitle(string, for: .normal)
    return self
  }
  
  @discardableResult
  public func setFontColor(customColor: UIColor = DesignSystemAsset.main1.color) -> Self {
    if let title = self.titleLabel, let text = title.text {
      let string = UIFont.zaniAttributedString(text: text, fontType: .title2)
      self.setAttributedTitle(string, for: .normal)
    }
    
    return self
  }
}

private extension CustomLargeButton {
  
  func setUI(_ title: String) {
    self.layer.cornerRadius = 8
    self.backgroundColor = self.isEnabled ? DesignSystemAsset.mainYellow.color : DesignSystemAsset.mainGray.color
    self.setAttributedTitle(
      UIFont.zaniAttributedString(text: title, fontType: .title2),
      for: .normal
    )
    self.setAttributedTitle(
      UIFont.zaniAttributedString(text: title, fontType: .title2),
      for: .disabled
    )
  }
}

// MARK: Button Logic
extension CustomLargeButton {
  private func updateButtonState() {
    let normalTitle = self.attributedTitle(for: .normal)
    let disabledTitle = self.attributedTitle(for: .disabled) ?? normalTitle
    
    self.setAttributedTitle(normalTitle, for: .normal)
    self.setAttributedTitle(disabledTitle, for: .disabled)
    
    if self.isEnabled {
      self.backgroundColor = DesignSystemAsset.mainYellow.color
    } else {
      self.backgroundColor = DesignSystemAsset.mainGray.color
    }
  }
  
  public override var isHighlighted: Bool {
    didSet {
      animateButton(isHighlighted: isHighlighted)
    }
  }
  
  private func animateButton(isHighlighted: Bool) {
    UIView.animate(withDuration: 0.2, animations: {
      self.alpha = isHighlighted ? 0.6 : 1.0
    })
  }
}
