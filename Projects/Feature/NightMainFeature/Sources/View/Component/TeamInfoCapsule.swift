//
//  TeamInfoCapsule.swift
//  NightMainFeature
//
//  Created by 정도현 on 2/9/25.
//  Copyright © 2025 zani.com. All rights reserved.
//

import UIKit
import SnapKit

import CoreKit
import DesignSystem

public enum TeamInfoType {
  case time
  case category
  case people
  
  public var title: String {
    switch self {
    case .time:
      return "밤샘"
    case .category:
      return "카테고리"
    case .people:
      return "인원"
    }
  }
}

public class TeamInfoCapsule: UIView {
  
  private let infoType: TeamInfoType
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = self.infoType.title
    label.font = UIFont.ZANIFontType.button2.font
    label.textColor = .white
    return label
  }()
  
  private lazy var contentLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.ZANIFontType.button3.font
    label.textColor = .white
    label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    return label
  }()
  
  private lazy var capsuleStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.alignment = .center
    stackView.distribution = .fill
    return stackView
  }()
  
  private lazy var backgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 1/255, green: 14/255, blue: 17/255, alpha: 0.63)
    view.clipsToBounds = true
    return view
  }()
  
  init(infoType: TeamInfoType, content: String) {
    self.infoType = infoType
    super.init(frame: .zero)
    
    self.contentLabel.text = content
    
    self.setupUI()
    self.setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    backgroundView.layer.cornerRadius = bounds.height / 2
  }
}

private extension TeamInfoCapsule {
  func setupUI() {
    
  }
  
  func setupLayout() {
    capsuleStack.addArrangedSubview(titleLabel)
    capsuleStack.addArrangedSubview(contentLabel)
    
    self.addSubview(backgroundView)
    self.addSubview(capsuleStack)
    
    backgroundView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    capsuleStack.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview().inset(14)
      make.verticalEdges.equalToSuperview().inset(2)
    }
  }
}
