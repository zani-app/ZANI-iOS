//
//  NightMainVC.swift
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

public class NightMainVC: UIViewController {
  
  public var viewModel: NightViewModel!
  
  private let input: PassthroughSubject<NightViewModel.Input, Never> = .init()
  private var cancelBag = CancelBag()
  
  private lazy var nightView1: NightIndicator = {
    let nightView = NightIndicator(nightType: .inNight)
    return nightView
  }()
  
  private lazy var nightView2: NightIndicator = {
    let nightView = NightIndicator(nightType: .inTeam)
    return nightView
  }()
  
  private lazy var nightView3: NightIndicator = {
    let nightView = NightIndicator(nightType: .noTeam)
    return nightView
  }()
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    self.bind()
    self.setUI()
    self.setLayout()
  }
}

private extension NightMainVC {
  func bind() {
    let output = viewModel.transform(from: input.eraseToAnyPublisher())
    
    self.nightView1.activeButtonTap
      .compactMap { _ in () }
      .receive(on: RunLoop.main)
      .sink(receiveValue: { [weak self] in
        self?.input.send(.tappedEnterButton)
      })
      .store(in: cancelBag)
  }
}

private extension NightMainVC {
  func setUI() {
    self.view.backgroundColor = DesignSystemAsset.main1.color
  }
  
  func setLayout() {
    self.view.addSubview(nightView1)
    self.view.addSubview(nightView2)
    self.view.addSubview(nightView3)
    
    nightView1.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      make.leading.trailing.equalToSuperview().inset(20)
      make.centerX.equalTo(self.view)
    }
    
    nightView2.snp.makeConstraints { make in
      make.top.equalTo(nightView1.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview().inset(20)
    }
    
    nightView3.snp.makeConstraints { make in
      make.top.equalTo(nightView2.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview().inset(20)
    }
  }
}
