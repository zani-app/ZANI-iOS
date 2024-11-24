//
//  NightIndicator.swift
//  NightMainFeatureInterface
//
//  Created by 정도현 on 11/24/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Combine
import UIKit

import CoreKit
import DesignSystem

import SnapKit

public enum NightIndicatorType {
  case noTeam   // 팀 없음
  case inTeam   // 팀에 속해 있음
  case inNight  // 밤샘 중
  
  public var title: String? {
    switch self {
    case .noTeam, .inTeam:
      return nil
    case .inNight:
      return "밤샘 진행 중 입니다!"
    }
  }
  
  public var subTitle: String {
    switch self {
    case .noTeam:
      return "아직 밤샘 팀에 가입되어 있지 않습니다.\n모집페이지에서 밤샘팀을 구할 수 있어요!"
    case .inTeam:
      return "밤샘메이트들과 함께 밤샘해요!\n참여하기 버튼을 누르면 팀페이지로 이동합니다."
    case .inNight:
      return "Tip. 미션 타임라인을 통해 다른 팀원들의 미션 성공 내역을 확인할 수 있습니다"
    }
  }
  
  public var buttonText: String {
    switch self {
    case .noTeam:
      return "밤샘 팀 구하기"
    case .inTeam:
      return "밤샘 참여하기"
    case .inNight:
      return "팀 페이지 이동"
    }
  }
  
  public var buttonColor: UIColor {
    switch self {
    case .noTeam:
      return .init(white: 1, alpha: 0.8)
    case .inTeam:
      return DesignSystemAsset.mainYellow.color
    case .inNight:
      return DesignSystemAsset.lightPurple.color
    }
  }
  
  public var backgroundColors: [CGColor] {
    switch self {
    case .noTeam:
      return [
        .init(red: 67/255, green: 54/255, blue: 202/255, alpha: 1),
        .init(red: 115/255, green: 99/255, blue: 177/255, alpha: 1)
      ]
    case .inTeam, .inNight:
      return [
        .init(red: 37/255, green: 31/255, blue: 97/255, alpha: 1),
        .init(red: 47/255, green: 33/255, blue: 103/255, alpha: 1)
      ]
    }
  }
}

public class NightIndicator: UIView {
  
  public lazy var activeButtonTap = activeButton.publisher(for: .touchUpInside)
  
  let nightType: NightIndicatorType
  
  private lazy var titleLabel: UILabel = {
    let title = UILabel()
    
    if let titleText = self.nightType.title {
      title.attributedText = UIFont.zaniAttributedString(text: titleText, fontType: .title1)
      title.isHidden = false
    } else {
      title.isHidden = true
    }
    title.numberOfLines = 1
    title.textColor = .white
    title.textAlignment = .left
    return title
  }()
  
  private lazy var subTitleLabel: UILabel = {
    let title = UILabel()
    title.attributedText = UIFont.zaniAttributedString(text: self.nightType.subTitle, fontType: .body1)
    title.numberOfLines = 2
    title.textColor = .white
    title.textAlignment = .left
    return title
  }()
  
  private lazy var activeButton: UIButton = {
    let button = UIButton()
    
    var configuration = UIButton.Configuration.filled()
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 9, leading: 15, bottom: 9, trailing: 15)
    configuration.background.cornerRadius = 17
    configuration.baseBackgroundColor = nightType.buttonColor
    configuration.baseForegroundColor = DesignSystemAsset.main1.color
    configuration.attributedTitle = AttributedString(
      UIFont.zaniAttributedString(
        text: self.nightType.buttonText,
        fontType: .body2
      )
    )
    configuration.background.strokeColor = DesignSystemAsset.main4.color
    configuration.background.strokeWidth = 1
    button.configuration = configuration
    return button
  }()
  
  init(nightType: NightIndicatorType) {
    self.nightType = nightType
    super.init(frame: .zero)
    
    self.setUI()
    self.setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    if let gradientLayer = self.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
      gradientLayer.frame = self.bounds
    }
  }
}

private extension NightIndicator {
  func setUI() {
    self.layer.cornerRadius = 20
    self.layer.masksToBounds = true
    
    // Gradient Layer
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.bounds
    gradientLayer.colors = nightType.backgroundColors
    gradientLayer.startPoint = CGPoint(x: 0.75, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 0.25, y: 1.0)
    gradientLayer.cornerRadius = 20
    
    self.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  func setLayout() {
    self.addSubview(titleLabel)
    self.addSubview(subTitleLabel)
    self.addSubview(activeButton)
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(30)
      make.leading.trailing.equalToSuperview().inset(20)
    }
    
    subTitleLabel.snp.makeConstraints { make in
      
      if nightType == .inNight {
        make.top.equalTo(titleLabel.snp.bottom).offset(20)
      } else {
        make.top.equalToSuperview().offset(40)
      }
      make.leading.trailing.equalToSuperview().inset(20)
    }
    
    activeButton.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(183)
      make.bottom.trailing.equalToSuperview().offset(-16)
    }
  }
}
