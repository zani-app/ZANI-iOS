//
//  CylinderGauge.swift
//  NightMainFeature
//
//  Created by 정도현 on 2/11/25.
//  Copyright © 2025 zani.com. All rights reserved.
//

import UIKit

import DesignSystem

final class CylinderGauge: UIView {

  private let backgroundLayer = CALayer()
  private let gradientLayer = CAGradientLayer()
  private let progressLayer = CAShapeLayer()

  private lazy var progress: CGFloat = 0 {
    didSet {
      updateProgress()
    }
  }

  private lazy var progressLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.ZANIFontType.button2.font
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }

  private func setupView() {
    // background layer
    backgroundLayer.backgroundColor = UIColor.white.cgColor
    layer.addSublayer(backgroundLayer)

    // gradient layer
    gradientLayer.colors = [
      UIColor.black.cgColor,
      UIColor(red: 0, green: 208 / 255, blue: 255 / 255, alpha: 1).cgColor,
    ]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    layer.addSublayer(gradientLayer)

    // progress layer
    progressLayer.fillColor = UIColor.white.cgColor
    gradientLayer.mask = progressLayer
    
    addSubview(progressLabel)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    // background layer
    backgroundLayer.frame = bounds.insetBy(dx: -2, dy: -2)
    backgroundLayer.cornerRadius = backgroundLayer.frame.height / 2

    // gradient layer
    gradientLayer.frame = bounds
    gradientLayer.cornerRadius = bounds.height / 2
    
    progressLabel.frame = CGRect(x: 10, y: 0, width: bounds.width - 20, height: bounds.height)
        
    updateProgress()
  }

  private func updateProgress() {
    let progressText = "\(Int(progress * 100))"
    progressLabel.text = progressText
    
    let progressWidth = bounds.width * progress
    let path = UIBezierPath(
      roundedRect: CGRect(
        x: 0, y: 0, width: progressWidth, height: bounds.height),
      cornerRadius: bounds.height / 2
    )

    progressLayer.path = path.cgPath
  }
}

extension CylinderGauge {
  
  @discardableResult
  func setProgress(_ progress: Double) -> Self {
    self.progress = progress
    return self
  }
}
