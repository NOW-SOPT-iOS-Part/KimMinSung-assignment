//
//  HomeTabViewModel.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/06/08.
//

import UIKit

import RxSwift

final class HomeTabViewModel {
    
    /*
     
     */
    var pageVC: UIPageViewController! {
        // pageVC의 초기 설정
        didSet { self.pageVC.setViewControllers([self.vcArray[0]], direction: .forward, animated: false) }
    }
    
    let vcArray = [HomeViewController(), LiveViewController(), TVProgramViewController(), MovieViewController(), ParamountPlusViewController()]
    
    //RxSwift
    let disposeBag = DisposeBag()
    
    var currentIndex: Int {
//        guard let pageVC else { return 0 }
        guard let currentViewControllers = pageVC.viewControllers else { return 0 }
        return self.vcArray.firstIndex(of: currentViewControllers[0]) ?? 0
    }
    
}
