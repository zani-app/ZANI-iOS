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
    case extraTitle
    case title1
    case title2
    case head1
    case head2BL
    case head2BS
    case button1
    case button2
    case button3
    case button4
    case body1
    case body2
    case navi
    
    public var font: UIFont {
      switch self {
      case .extraTitle:
        return DesignSystemFontFamily.Pretendard.bold.font(size: 48)
      case .title1:
        return DesignSystemFontFamily.Pretendard.bold.font(size: 26)
      case .title2:
        return DesignSystemFontFamily.Pretendard.bold.font(size: 23)
      case .head1:
        return DesignSystemFontFamily.Pretendard.bold.font(size: 20)
      case .head2BL:
        return DesignSystemFontFamily.Pretendard.bold.font(size: 16)
      case .head2BS:
        return DesignSystemFontFamily.Pretendard.bold.font(size: 13)
      case .button1:
        return DesignSystemFontFamily.Pretendard.semiBold.font(size: 16)
      case .button2:
        return DesignSystemFontFamily.Pretendard.semiBold.font(size: 12)
      case .button3:
        return DesignSystemFontFamily.Pretendard.regular.font(size: 12)
      case .button4:
        return DesignSystemFontFamily.Pretendard.regular.font(size: 11)
      case .body1:
        return DesignSystemFontFamily.Pretendard.regular.font(size: 15)
      case .body2:
        return DesignSystemFontFamily.Pretendard.regular.font(size: 13)
      case .navi:
        return DesignSystemFontFamily.Pretendard.regular.font(size: 10)
      }
    }
    
    var lineHeight: CGFloat {
      switch self {
      case .extraTitle:
        return 20
      case .title1:
        return 20
      case .title2:
        return 20
      case .head1:
        return 20
      case .head2BL:
        return 20
      case .head2BS:
        return 20
      case .button1:
        return 20
      case .button2:
        return 20
      case .button3:
        return 20
      case .button4:
        return 20
      case .body1:
        return 22
      case .body2:
        return 22
      case .navi:
        return 20
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
  
  public static func zaniAttributedString(text: String, fontType: ZANIFontType) -> NSAttributedString {
    return fontType.attributedString(text: text)
  }
}
