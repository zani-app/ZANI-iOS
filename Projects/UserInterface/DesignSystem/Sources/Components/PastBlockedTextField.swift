//
//  PastBlockedTextField.swift
//  DesignSystem
//
//  Created by 정도현 on 11/4/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import UIKit

final class PastBlockedTextField: UITextField {
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if action == #selector(UIResponderStandardEditActions.paste(_:)) {
      return false
    }
    
    return super.canPerformAction(action, withSender: sender)
  }
}
