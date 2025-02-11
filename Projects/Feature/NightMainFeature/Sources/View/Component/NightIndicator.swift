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
  
  public var backgroundImage: UIImage {
    switch self {
    case .noTeam:
      return DesignSystemAsset.noTeamNightBackground.image
    case .inTeam:
      return DesignSystemAsset.inTeamNightBackground.image
    }
  }
}

public class NightIndicator: UIView {
  
  let nightType: NightIndicatorType
  
  var imageRatio: CGFloat = 1.0
  
  private lazy var nightBackground: UIImageView = {
    let imageView: UIImageView = UIImageView(image: self.nightType.backgroundImage)
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
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
}

private extension NightIndicator {
  func setUI() {
    if let image = nightBackground.image {
      self.imageRatio = image.size.height / image.size.width
    }
  }
  
  func setLayout() {
    self.addSubview(nightBackground)
    
    nightBackground.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
