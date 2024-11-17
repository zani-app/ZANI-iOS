//
//  ViewController + Ex.swift
//  CoreKit
//
//  Created by 정도현 on 11/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import UIKit

// MARK: - Hide Keyboard
public extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
