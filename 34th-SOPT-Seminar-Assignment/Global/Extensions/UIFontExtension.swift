//
//  UIFontExtension.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/14.
//

import UIKit

enum PretendardFont: CGFloat {
    case thin = 100
    case extraLight = 200
    case light = 300
    case regular = 400
    case medium = 500
    case semiBold = 600
    case bold = 700
    case extraBold = 800
    case Black = 900
}



extension UIFont {
    
    /// (Figma에서) 특정 폰트의 weight가 수치로 표현되어있을 때, 각 두께로 바꿔서 UIFont 인스턴스를 반환함.
    /// - Parameters:
    ///   - fontSize: font의 사이즈
    ///   - weight: font의 weight
    /// - Returns: 특정 size와 weight의 UIFont 인스턴스
    static func pretendardFont(ofSize fontSize: CGFloat, weight: CGFloat) -> UIFont {
        let fontName: String
        
        switch weight {
        case PretendardFont.thin.rawValue:
            fontName = "Pretendard-Thin"
        case PretendardFont.extraLight.rawValue:
            fontName = "Pretendard-ExtraLight"
        case PretendardFont.light.rawValue:
            fontName = "Pretendard-Light"
        case PretendardFont.regular.rawValue:
            fontName = "Pretendard-Regular"
        case PretendardFont.medium.rawValue:
            fontName = "Pretendard-Medium"
        case PretendardFont.semiBold.rawValue:
            fontName = "Pretendard-SemiBold"
        case PretendardFont.bold.rawValue:
            fontName = "Pretendard-Bold"
        case PretendardFont.extraBold.rawValue:
            fontName = "Pretendard-ExtraBold"
        case PretendardFont.Black.rawValue:
            fontName = "Pretendard-Black"
        default:
            fatalError("Invalid weight")
        }
        
        guard let font = UIFont(name: fontName, size: fontSize) else { fatalError("Font not found") }
        return font
    }
}


extension UIFont {
    
    /// Pretendard 폰트의 특정 weight를 이용해 Pretendard 폰트의 UIFont 인스턴스를 반환 (마치 systemFont처럼)
    /// - Parameters:
    ///   - fontSize: font의 사이즈
    ///   - weight: font의 weight
    /// - Returns: 특정 size와 weight의 UIFont 인스턴스
    static func pretendardFont(ofSize fontSize: CGFloat, weight: PretendardFont) -> UIFont {
        let fontName: String
        switch weight {
        case .thin:
            fontName = "Pretendard-Thin"
        case .extraLight:
            fontName = "Pretendard-ExtraLight"
        case .light:
            fontName = "Pretendard-Light"
        case .regular:
            fontName = "Pretendard-Regular"
        case .medium:
            fontName = "Pretendard-Medium"
        case .semiBold:
            fontName = "Pretendard-SemiBold"
        case .bold:
            fontName = "Pretendard-Bold"
        case .extraBold:
            fontName = "Pretendard-ExtraBold"
        case .Black:
            fontName = "Pretendard-Black"
        }
        
        guard let font = UIFont(name: fontName, size: fontSize) else { fatalError("Font not found") }
        return font
    }
}
