//
//  NavigationBar.swift
//  DesignSystem
//
//  Created by 정도현 on 11/4/24.
//  Copyright © 2024 zani.com. All rights reserved.
//


import UIKit

import CoreKit

import SnapKit

final public class NavigationBar: UIView {
  
  // MARK: - Properties
  public lazy var leftButtonTap = leftButton.publisher(for: .touchUpInside)
  public lazy var rightButtonTap = rightButton.publisher(for: .touchUpInside)
  
  // MARK: - UI Components
  private let leftButton: UIButton = {
    let button = UIButton()
    button.contentMode = .scaleAspectFit
    button.tintColor = .white
    return button
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.ZANIFontType.title1.font
    label.textColor = .white
    label.textAlignment = .center
    return label
  }()
  
  private let rightButton: UIButton = {
    let button = UIButton()
    button.contentMode = .scaleAspectFit
    button.tintColor = .white
    return button
  }()
  
  private var cancelBag = CancelBag()
  
  // MARK: - Initializer
  public init(
    leftIcon: UIImage? = nil,
    title: String? = nil,
    rightIcon: UIImage? = nil
  ) {
    super.init(frame: .zero)
    
    leftButton.setImage(leftIcon, for: .normal)
    titleLabel.text = title
    rightButton.setImage(rightIcon, for: .normal)
    
    setUI()
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Methods
extension NavigationBar {
  @discardableResult
  public func setRightButtonImage(image: UIImage) -> Self {
    self.rightButton.setImage(image, for: .normal)
    return self
  }
  
  @discardableResult
  public func setLeftButtonImage(image: UIImage) -> Self {
    self.leftButton.setImage(image, for: .normal)
    return self
  }
}

// MARK: - UI & Layout
extension NavigationBar {
  private func setUI() {
    self.backgroundColor = DesignSystemAsset.main1.color
  }
  
  private func setLayout() {
    self.addSubview(leftButton)
    self.addSubview(titleLabel)
    self.addSubview(rightButton)
    
    self.snp.makeConstraints { make in
      make.height.equalTo(56)
    }
    
    leftButton.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.width.equalTo(32)
      make.leading.equalToSuperview().inset(12)
      make.centerY.equalTo(self)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(16)
      make.centerX.equalTo(self)
      make.centerY.equalTo(self)
    }
    
    rightButton.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.width.equalTo(32)
      make.trailing.equalToSuperview().inset(12)
      make.centerY.equalTo(self)
    }
  }
}
