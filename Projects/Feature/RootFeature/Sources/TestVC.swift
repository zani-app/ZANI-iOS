//
//  TestVC.swift
//  RootFeature
//
//  Created by 정도현 on 10/6/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import UIKit

import CoreKit
import DesignSystem

import SnapKit

public class TestVC: UIViewController {
  
  private var cancelBag = CancelBag()
  
  let authTextField = AuthTextField(type: .email)
  let largeButton: UIButton = CustomLargeButton(title: "test")
    .setEnabled(false)
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.setUI()
    self.setLayout()
    self.setActions()
  }
}

private extension TestVC {
  func setActions() {
    largeButton.addTarget(self, action: #selector(handleLargeButtonTap), for: .touchUpInside)
  }
  
  @objc func handleLargeButtonTap() {
    print("Large button tapped!")
  }
}

private extension TestVC {
  func setUI() {
    self.view.backgroundColor = DesignSystemAsset.main1.color
    self.navigationController?.navigationBar.isHidden = true
  }
  
  func setLayout() {
    self.view.addSubview(authTextField)
    self.view.addSubview(largeButton)
    
    authTextField.snp.makeConstraints { make in
      make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
    }
    
    largeButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(authTextField.snp.bottom).offset(30)
      make.height.equalTo(40)
    }
  }
}
