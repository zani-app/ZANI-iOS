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
  
  public var viewModel: AuthViewModel!
  
  private let input: PassthroughSubject<AuthViewModel.Input, Never> = .init()
  private var cancelBag = CancelBag()
  
  private lazy var titleImage: UIImageView = {
    let image = DesignSystemAsset.authDoneCheckIcon.image
    return UIImageView(image: image)
  }()
  
  private lazy var titleLabel: UILabel = {
    let title = UILabel()
    title.attributedText = UIFont.zaniAttributedString(
      text: "회원가입이 완료되었습니다!",
      fontType: .head1
    )
    title.textColor = .white
    title.textAlignment = .center
    return title
  }()
  
  private lazy var subTitleLabel: UILabel = {
    let title = UILabel()
    title.attributedText = UIFont.zaniAttributedString(
      text: "밤샘 팀에 가입하여 메이트들과\n밤샘을 함께 성공해요!",
      fontType: .body1
    )
    title.numberOfLines = 2
    title.textColor = .white
    title.textAlignment = .center
    return title
  }()
  
  private lazy var nextButton: CustomLargeButton = {
    let button = CustomLargeButton(title: "다음")
    button.setEnabled(true)
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
    let output = viewModel.transform(from: input.eraseToAnyPublisher())
    
    self.nextButton
      .publisher(for: .touchUpInside)
      .compactMap { _ in () }
      .receive(on: RunLoop.main)
      .sink(receiveValue: { [weak self] in
        self?.input.send(.tappedSignUpSuccessButton)
      })
      .store(in: cancelBag)
  }
}

private extension SignUpDoneVC {
  func setUI() {
    self.view.backgroundColor = DesignSystemAsset.main1.color
  }
  
  func setLayout() {
    self.view.addSubview(titleImage)
    self.view.addSubview(titleLabel)
    self.view.addSubview(subTitleLabel)
    self.view.addSubview(nextButton)
    
    titleImage.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
      make.centerX.equalTo(self.view)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(titleImage.snp.bottom).offset(63)
      make.centerX.equalTo(self.view)
    }
    
    subTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(7)
      make.centerX.equalTo(self.view)
    }
    
    nextButton.snp.makeConstraints { make in
      make.height.equalTo(48)
      make.leading.trailing.equalToSuperview().inset(20)
      make.centerX.equalTo(self.view)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8)
    }
  }
}
