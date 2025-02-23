//
//  NightTimer.swift
//  NightMainFeature
//
//  Created by 정도현 on 2/11/25.
//  Copyright © 2025 zani.com. All rights reserved.
//

import UIKit
import SnapKit

import CoreKit
import DesignSystem

public class NightTimer: UIView {
  
  private lazy var titleLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "밤샘 누적 시간"
    label.font = UIFont.ZANIFontType.head2BS.font
    label.textColor = .white
    return label
  }()
  
  private lazy var timerLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont.ZANIFontType.extraTitle.font
    label.textColor = .white
    return label
  }()
  
  private let gaugeView: CylinderGauge = CylinderGauge()
  
  init(timer: String) {
    super.init(frame: .zero)
    
    self.timerLabel.text = timer
    
    self.setUI()
    self.setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension NightTimer {
  func setUI() {
    self.gaugeView.setProgress(0.8)
  }
  
  func setLayout() {
    self.addSubview(titleLabel)
    self.addSubview(timerLabel)
    self.addSubview(gaugeView)
    
    titleLabel.snp.makeConstraints { make in
      make.top.trailing.equalToSuperview()
    }
    
    timerLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(7)
      make.trailing.equalToSuperview()
    }
    
    gaugeView.snp.makeConstraints { make in
      make.height.equalTo(20)
      make.width.equalToSuperview()
      make.trailing.equalToSuperview()
      make.top.equalTo(timerLabel.snp.bottom).offset(30)
      make.bottom.equalToSuperview()
    }
  }
}
