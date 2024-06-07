//
//  CustomSegmentedControlType.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/07.
//

import UIKit

// 프로토콜을 생성하긴 했는데, 추상화를 통한 DI 는 구현하지 못함. (생각보다 복잡한 것 같아서 추후 구현 시도해볼 예정)
protocol CustomSegmentedControlType: AnyObject {
    
    init(titles: [String])
    
    var topAnchor: NSLayoutYAxisAnchor { get }
    var separator: UIView { get }
    var buttons: [UIView] { get }
    
    func moveUnderbarPosition(to: Int)
    func select(at: Int)
    
}
