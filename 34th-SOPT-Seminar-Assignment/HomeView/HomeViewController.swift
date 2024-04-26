//
//  HomeViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let rootView = HomeView()
    
    override func loadView() {
        self.view = self.rootView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNaviBar()
    }
    
    
    
    private func setNaviBar() {
        self.title = "임시 타이틀"
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
    }
    
    
}
