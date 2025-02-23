//
//  NightActiveMainVC.swift
//  NightMainFeatureInterface
//
//  Created by 정도현 on 11/24/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Combine
import UIKit

import BaseDomain
import CoreKit
import DesignSystem

import SnapKit

public class NightActiveMainVC: UIViewController {
  
  public var viewModel: NightViewModel!
  
  private let input: PassthroughSubject<NightViewModel.Input, Never> = .init()
  private var cancelBag = CancelBag()
  
  private lazy var nightView1: NightIndicator = {
    let nightView = NightIndicator(nightType: .inTeam)
    return nightView
  }()
  
  private lazy var titleLabel: UILabel = {
    let title = UILabel()
    title.attributedText = UIFont.zaniAttributedString(
      text: "팀 이름입니다",
      fontType: .title1
    )
    title.numberOfLines = 1
    title.textColor = .white
    title.textAlignment = .left
    return title
  }()
  
  private lazy var descriptionLabel: UILabel = {
    let title = UILabel()
    title.attributedText = UIFont.zaniAttributedString(
      text: "팀 소개!!팀 소개!!팀 소개!!팀 소개!!팀 소개!!개!!팀 소개!!팀 소개!!팀 소개!!팀 소개!!팀 소개!!",
      fontType: .body2
    )
    title.numberOfLines = 3
    title.textColor = .white
    title.textAlignment = .left
    return title
  }()
  
  private lazy var timelineButton: UIButton = {
    let button = UIButton(configuration: .plain())
    
    button.configurationUpdateHandler = { btn in
      var config = btn.configuration ?? UIButton.Configuration.plain()
      var title = AttributedString("미션 타임라인")
      
      title.font = UIFont.ZANIFontType.button2.font
      title.foregroundColor = DesignSystemAsset.main2.color
      
      config.attributedTitle = title
      config.baseForegroundColor = DesignSystemAsset.main2.color
      config.background.cornerRadius = 20
      config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12)
      
      let symbolConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .medium, scale: .medium)
      config.image = UIImage(
        systemName: "chevron.right",
        withConfiguration: symbolConfig
      )?.withRenderingMode(.alwaysTemplate)
      config.imagePlacement = .trailing
      config.imagePadding = 6
      
      if btn.state == .highlighted {
        config.background.backgroundColor = UIColor(red: 0, green: 1, blue: 1, alpha: 1)
      } else {
        config.background.backgroundColor = UIColor(red: 0, green: 208/255, blue: 1, alpha: 1)
      }
      
      btn.configuration = config
    }
    
    return button
  }()
  
  private lazy var teamInfoStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 6
    stackView.alignment = .leading
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private lazy var nightInfo: TeamInfoCapsule = TeamInfoCapsule(infoType: .time, content: "밤샘시간")
  private lazy var categoryInfo: TeamInfoCapsule = TeamInfoCapsule(infoType: .category, content: "카테고리")
  private lazy var peopleInfo: TeamInfoCapsule = TeamInfoCapsule(infoType: .people, content: "인원")
  
  private lazy var timer: NightTimer = NightTimer(timer: "12:13")
  
//  private lazy var nightView2: NightIndicator = {
//    let nightView = NightIndicator(nightType: .noTeam)
//    return nightView
//  }()
  
  private let progressBar: CylinderGauge = CylinderGauge()
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    self.bind()
    self.setUI()
    self.setLayout()
  }
}

private extension NightActiveMainVC {
  func bind() {
    let output = viewModel.transform(from: input.eraseToAnyPublisher())
  }
}

private extension NightActiveMainVC {
  func setUI() {
    self.view.backgroundColor = DesignSystemAsset.main2.color
  }
  
  func setLayout() {
    teamInfoStack.addArrangedSubview(nightInfo)
    teamInfoStack.addArrangedSubview(peopleInfo)
    teamInfoStack.addArrangedSubview(categoryInfo)
    
    self.view.addSubview(nightView1)
    self.view.addSubview(titleLabel)
    self.view.addSubview(descriptionLabel)
    self.view.addSubview(timelineButton)
    self.view.addSubview(teamInfoStack)
    self.view.addSubview(timer)
    self.view.addSubview(progressBar)
    
    nightView1.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(nightView1.snp.width).multipliedBy(nightView1.imageRatio)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      make.leading.equalTo(view.safeAreaLayoutGuide).inset(28)
    }
    
    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(22)
      make.leading.equalTo(view.safeAreaLayoutGuide).inset(30)
      make.trailing.equalTo(view.safeAreaLayoutGuide).inset(102)
    }
    
    timelineButton.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      make.trailing.equalTo(view.safeAreaLayoutGuide).inset(22)
    }
    
    teamInfoStack.snp.makeConstraints { make in
      make.bottom.equalTo(nightView1.snp.bottom).offset(-26)
      make.leading.equalTo(view.safeAreaLayoutGuide).inset(30)
    }
    
    timer.snp.makeConstraints { make in
      make.width.equalToSuperview().multipliedBy(1.0/3.0)
      make.trailing.equalTo(view.safeAreaLayoutGuide).inset(14)
      make.bottom.equalTo(nightView1.snp.bottom).offset(-30)
    }
  }
}
