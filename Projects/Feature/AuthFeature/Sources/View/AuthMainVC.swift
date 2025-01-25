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
  
  public var viewModel: AuthMainViewModel!
  
  private let input: PassthroughSubject<AuthMainViewModel.Input, Never> = .init()
  private var cancelBag = CancelBag()
  
  private lazy var titleImage: UIImageView = {
    let imageView: UIImageView = UIImageView(image: DesignSystemAsset.doubleMoonIcon.image)
    return imageView
  }()
  
  private lazy var titleLabel: UILabel = {
    let title = UILabel()
    title.attributedText = UIFont.zaniAttributedString(
      text: "지금 자니에서\n밤샘메이트들과 함께 해보세요!",
      fontType: .title1
    )
    title.numberOfLines = 2
    title.textColor = .white
    title.textAlignment = .left
    return title
  }()
  
  private lazy var subTitleLabel: UILabel = {
    let title = UILabel()
    title.text = "자니를 이용할 계정을 선택해주세요"
    title.font = UIFont.ZANIFontType.body1.font
    title.textColor = DesignSystemAsset.mainGray.color
    title.numberOfLines = 1
    title.textAlignment = .left
    return title
  }()
  
  private lazy var loginButtonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    stackView.spacing = 16
    return stackView
  }()
  
  private lazy var kakaoLoginButton: UIButton = {
    let button = UIButton()
    button.setImage(DesignSystemAsset.kakaoLoginButton.image, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    return button
  }()
  
  private lazy var appleLoginButton: UIButton = {
    let button = UIButton()
    button.setImage(DesignSystemAsset.appleLoginButton.image, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    return button
  }()
  
  private lazy var googleLoginButton: UIButton = {
    let button = UIButton()
    button.setImage(DesignSystemAsset.googleLoginButton.image, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    return button
  }()
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    self.bind()
    self.setUI()
    self.setLayout()
  }
}

private extension AuthMainVC {
  func bind() {
    let output = viewModel.transform(from: input.eraseToAnyPublisher())
    
    buttonPublisher(for: kakaoLoginButton)
      .sink(receiveValue: { [weak self] in
        self?.input.send(.tappedKakaoLoginButton)
      })
      .store(in: cancelBag)
    
    buttonPublisher(for: appleLoginButton)
      .sink(receiveValue: { [weak self] in
        self?.input.send(.tappedAppleLoginButton)
      })
      .store(in: cancelBag)
    
    output
      .receive(on: RunLoop.main)
      .sink { [weak self] result in
        
      }
  }
  
  private func buttonPublisher(for button: UIButton) -> AnyPublisher<Void, Never> {
    button.publisher(for: .touchUpInside)
      .map { _ in () }
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
}

private extension AuthMainVC {
  func setUI() {
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
    self.view.addSubview(titleLabel)
    self.view.addSubview(subTitleLabel)
    self.view.addSubview(loginButtonStackView)
    
    loginButtonStackView.addArrangedSubview(kakaoLoginButton)
    loginButtonStackView.addArrangedSubview(appleLoginButton)
    loginButtonStackView.addArrangedSubview(googleLoginButton)
    
    titleImage.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(101)
      make.leading.equalToSuperview().inset(43)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(titleImage.snp.bottom).offset(15)
      make.leading.trailing.equalToSuperview().inset(48)
    }
    
    subTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(6)
      make.leading.trailing.equalToSuperview().inset(48)
    }
    
    loginButtonStackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
      make.centerX.equalTo(self.view)
    }
  }
}
