//
//  SignUpDoneVC.swift
//  AuthFeature
//
//  Created by 정도현 on 11/17/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Combine
import UIKit

import BaseDomain
import CoreKit
import DesignSystem

import SnapKit

public class SignUpDoneVC: UIViewController {
  
  private var cancelBag = CancelBag()
  
  private lazy var titleImage: UIImageView = {
    let image = DesignSystemAsset.checkedMoonIcon.image
    return UIImageView(image: image)
  }()
  
  private lazy var titleLabel: UILabel = {
    let title = UILabel()
    title.attributedText = UIFont.zaniAttributedString(
      text: "회원가입이\n완료되었습니다!",
      fontType: .title1
    )
    
    title.numberOfLines = 2
    title.textColor = .white
    title.textAlignment = .center
    return title
  }()
  
  private lazy var nextButton: CustomLargeButton = {
    let button = CustomLargeButton(title: "다음")
    button.setEnabled(true)
    button.setHeight(height: 48)
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

private extension SignUpDoneVC {
  func bind() {
//    let output = viewModel.transform(from: input.eraseToAnyPublisher())
//    
//    self.nextButton
//      .publisher(for: .touchUpInside)
//      .compactMap { _ in () }
//      .receive(on: RunLoop.main)
//      .sink(receiveValue: { [weak self] in
//        self?.input.send(.tappedSignUpSuccessButton)
//      })
//      .store(in: cancelBag)
  }
}

private extension SignUpDoneVC {
  func setUI() {
    self.view.backgroundColor = DesignSystemAsset.main1.color
    
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
    self.view.addSubview(nextButton)
    
    titleImage.snp.makeConstraints { make in
      make.centerX.equalTo(self.view)
      make.centerY.equalTo(self.view).offset(-60)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(titleImage.snp.bottom).offset(14)
      make.centerX.equalTo(self.view)
    }
    
    nextButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.centerX.equalTo(self.view)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
    }
  }
}
