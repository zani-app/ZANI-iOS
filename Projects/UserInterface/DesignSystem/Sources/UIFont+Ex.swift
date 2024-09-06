//
//  UIFont+Ex.swift
//  DesignSystem
//
//  Created by 정도현 on 9/6/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import UIKit

extension UIFont {
  public enum ZANIFontType {
    case head1
    case head2
    case title1
    case title2
    case title3
    case body1
    case body2
    case body2Bold
    case navi
    
    public var font: UIFont {
      switch self {
      case .head1:
        return DesignSystemFontFamily.Pretendard.bold.font(size: 28)
      case .head2:
        return DesignSystemFontFamily.Pretendard.bold.font(size: 36)
      case .title1:
        return DesignSystemFontFamily.Pretendard.bold.font(size: 20)
      case .title2:
        return DesignSystemFontFamily.Pretendard.bold.font(size: 16)
      case .title3:
        return DesignSystemFontFamily.Pretendard.bold.font(size: 16)
      case .body1:
        return DesignSystemFontFamily.Pretendard.regular.font(size: 16)
      case .body2:
        return DesignSystemFontFamily.Pretendard.regular.font(size: 14)
      case .body2Bold:
        return DesignSystemFontFamily.Pretendard.bold.font(size: 14)
      case .navi:
        return DesignSystemFontFamily.Pretendard.regular.font(size: 12)
      }
    }
    
    var lineHeight: CGFloat {
      switch self {
      case .head1: return 44
      case .head2: return 43
      case .title1: return 24
      case .title2: return 19
      case .title3: return 19
      case .body1: return 19
      case .body2: return 17
      case .body2Bold: return 17
      case .navi: return 16
      }
    }
    
    // Font + Lineheight 적용을 한 AttributedString 생성
    public func attributedString(text: String) -> NSAttributedString {
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.minimumLineHeight = self.lineHeight
      paragraphStyle.maximumLineHeight = self.lineHeight
      
      let baselineOffsetFactor: CGFloat
      if #available(iOS 16.4, *) {
        baselineOffsetFactor = 2
      } else {
        baselineOffsetFactor = 4
      }
      
      let baselineOffset = (self.lineHeight - self.font.lineHeight) / baselineOffsetFactor
      
      let attributes: [NSAttributedString.Key: Any] = [
        .font: self.font,
        .paragraphStyle: paragraphStyle,
        .baselineOffset: baselineOffset
      ]
      
      return NSAttributedString(string: text, attributes: attributes)
    }
  }
  
  static func zaniAttributedString(text: String, fontType: ZANIFontType) -> NSAttributedString {
    return fontType.attributedString(text: text)
  }
}
