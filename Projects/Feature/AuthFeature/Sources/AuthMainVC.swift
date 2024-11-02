//
//  AuthMainVC.swift
//  AuthFeatureInterface
//
//  Created by 정도현 on 10/7/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Combine
import UIKit

import BaseDomain
import CoreKit
import DesignSystem

import SnapKit

public class AuthMainVC: UIViewController {
  
  private lazy var titleLabel: UILabel = {
    let title = UILabel()
    title.text = "로그인/회원가입"
    title.font = UIFont.ZANIFontType.head2.font
    title.textColor = .white
    title.textAlignment = .center
    return title
  }()
  
  private lazy var subTitleLabel: UILabel = {
    let title = UILabel()
    title.text = "밤샘메이트들과 함께하는\n밤샘 서비스, 자니"
    title.font = UIFont.ZANIFontType.title2.font
    title.textColor = DesignSystemAsset.mainGray.color
    title.numberOfLines = 2
    title.textAlignment = .center
    return title
  }()
  
  private lazy var appleLoginButton: UIButton = {
    let button = UIButton()
    button.setImage(DesignSystemAsset.appleLoginBtnImage.image, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    return button
  }()
  
  private lazy var kakaoLoginButton: UIButton = {
    let button = UIButton()
    button.setImage(DesignSystemAsset.kakaoLoginBtnImage.image, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    return button
  }()
  
  private lazy var emailLoginButton: UIButton = {
    let button = UIButton(type: .system)
    
    var config = UIButton.Configuration.filled()
    config.baseBackgroundColor = DesignSystemAsset.mainGray.color
    config.baseForegroundColor = .black
    button.configuration = config
    
    button.layer.cornerRadius = 26
    button.layer.masksToBounds = true
    
    button.setAttributedTitle(
      UIFont.zaniAttributedString(text: "이메일로 로그인하기", fontType: .title2),
      for: .normal
    )
    
    return button
  }()
  
  private lazy var emailSignUpText: UILabel = {
    let label = UILabel()
    label.text = "이메일로 회원가입"
    label.font = UIFont.ZANIFontType.body1.font
    label.textColor = DesignSystemAsset.mainGray.color
    label.textAlignment = .center
    return label
  }()
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.setUI()
    self.setLayout()
  }
}

private extension AuthMainVC {
  func setUI() {
    self.view.backgroundColor = DesignSystemAsset.main1.color
  }
  
  func setLayout() {
    self.view.addSubview(titleLabel)
    self.view.addSubview(subTitleLabel)
    self.view.addSubview(kakaoLoginButton)
    self.view.addSubview(appleLoginButton)
    self.view.addSubview(emailLoginButton)
    self.view.addSubview(emailSignUpText)
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(180)
      make.centerX.equalTo(self.view)
    }
    
    subTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(12)
      make.centerX.equalTo(self.view)
    }
    
    kakaoLoginButton.snp.makeConstraints { make in
      make.height.equalTo(52)
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalTo(appleLoginButton.snp.top).offset(-16)
      make.centerX.equalTo(self.view)
    }
    
    appleLoginButton.snp.makeConstraints { make in
      make.height.equalTo(52)
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalTo(emailLoginButton.snp.top).offset(-16)
      make.centerX.equalTo(self.view)
    }
    
    emailLoginButton.snp.makeConstraints { make in
      make.height.equalTo(52)
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalTo(emailSignUpText.snp.top).offset(-29)
      make.centerX.equalTo(self.view)
    }
    
    emailSignUpText.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-87)
      make.centerX.equalTo(self.view)
    }
  }
}
