//
//  NightDeactiveMainVC.swift
//  NightMainFeature
//
//  Created by 정도현 on 2/23/25.
//  Copyright © 2025 zani.com. All rights reserved.
//

import Combine
import UIKit

import BaseDomain
import CoreKit
import DesignSystem

import SnapKit

public class NightDeactiveMainVC: UIViewController {
  
  public var viewModel: NightViewModel!
  
  private let input: PassthroughSubject<NightViewModel.Input, Never> = .init()
  private var cancelBag = CancelBag()
  
  private lazy var nightIndicator: NightIndicator = {
    let nightView = NightIndicator(nightType: .noTeam)
    return nightView
  }()

  private lazy var titleLabel: UILabel = {
    let title = UILabel()
    title.attributedText = UIFont.zaniAttributedString(
      text: "밤샘 팀이\n존재하지 않습니다.",
      fontType: .title1
    )
    title.numberOfLines = 2
    title.textColor = .white
    title.textAlignment = .center
    return title
  }()
  
  private lazy var descriptionLabel: UILabel = {
    let title = UILabel()
    title.attributedText = UIFont.zaniAttributedString(
      text: "친구에게 링크를 받거나\n어쩌고 저쩌고 팀을 생성하세요.",
      fontType: .body2
    )
    title.numberOfLines = 2
    title.textColor = .white
    title.textAlignment = .center
    return title
  }()
  
  private lazy var generateTeamButton: UIButton = {
    let button = UIButton(configuration: .plain())
    
    button.configurationUpdateHandler = { btn in
      var config = btn.configuration ?? UIButton.Configuration.plain()
      var title = AttributedString("팀 생성하기")
      
      title.font = UIFont.ZANIFontType.button1.font
      title.foregroundColor = DesignSystemAsset.main2.color
      
      config.attributedTitle = title
      config.baseForegroundColor = DesignSystemAsset.mainYellow.color
      config.background.cornerRadius = 22
      config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24)
      
      if btn.state == .highlighted {
        config.background.backgroundColor = DesignSystemAsset.mainYellow.color.withAlphaComponent(0.6)
      } else {
        config.background.backgroundColor = DesignSystemAsset.mainYellow.color
      }
      
      btn.configuration = config
    }
    
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

private extension NightDeactiveMainVC {
  func bind() {
    let output = viewModel.transform(from: input.eraseToAnyPublisher())
  }
}

private extension NightDeactiveMainVC {
  func setUI() {
    self.view.backgroundColor = DesignSystemAsset.main2.color
  }
  
  func setLayout() {
    self.view.addSubview(nightIndicator)
    self.view.addSubview(titleLabel)
    self.view.addSubview(descriptionLabel)
    self.view.addSubview(generateTeamButton)
    
    nightIndicator.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(nightIndicator.snp.width).multipliedBy(nightIndicator.imageRatio)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(20)
    }
    
    descriptionLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(titleLabel.snp.bottom).offset(15)
    }
    
    generateTeamButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(descriptionLabel.snp.bottom).offset(42)
    }
  }
}
