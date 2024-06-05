//
//  HomeBoxOfficeHeaderView.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/05/10.
//

import UIKit

protocol BoxOfficeController: AnyObject {
    func changeBoxOfficeDate(to targetDateDistance: DateDistanceFromToday)
}

enum DateDistanceFromToday: Int {
    case yesterday = 1
    case theDayBeforeYesterday = 2
    case threeDaysAgo = 3
}

final class HomeBoxOfficeHeaderView: UICollectionReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    /// 확인하고자 하는 박스오피스 날짜가 오늘로부터 며칠 전인지를 결정
    var boxOfficeSelectedDate: DateDistanceFromToday = .yesterday {
        didSet {
            self.delegate?.changeBoxOfficeDate(to: boxOfficeSelectedDate)
            
            guard let targetDate = Calendar(identifier: .gregorian).date(
                byAdding: .day,
                value: -boxOfficeSelectedDate.rawValue,
                to: Date.now
            ) else { fatalError() }
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR") // 지역 및 언어에 따라 현지화 필요할 수도
            dateFormatter.dateFormat = "M월 d일(E)"
            
            let dateInString: String = dateFormatter.string(from: targetDate)
            
            switch boxOfficeSelectedDate {
            case .yesterday:
                self.boxOfficeDateLabel.text = "어제: " + dateInString
            case .theDayBeforeYesterday:
                self.boxOfficeDateLabel.text = "그저께: " + dateInString
            case .threeDaysAgo:
                self.boxOfficeDateLabel.text = "3일 전: " + dateInString
            }
        }
    }
    
    weak var delegate: BoxOfficeController?
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 15, weight: 600)
        label.textColor = .white
        return label
    }()
    
    private let dateLeftButton: UIButton = {
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "arrowtriangle.left.fill")
        configuration.baseForegroundColor = .lightGray
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let button = UIButton(configuration: configuration)
        button.tag = -1
        return button
    }()
    
    private lazy var boxOfficeDateLabel: UILabel = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR") // 지역 및 언어에 따라 현지화 필요할 수도
        dateFormatter.dateFormat = "M월 d일(E)"
        let dateInString: String = dateFormatter.string(from: Date.now)
        
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 12, weight: 400)
        label.text = "어제: " + dateInString
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let dateRightButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "arrowtriangle.right.fill")
        configuration.baseForegroundColor = .lightGray
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let button = UIButton(configuration: configuration)
        button.tag = 1
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureViewHierarchy()
        self.setAutoLayout()
        self.setButtonsAction()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewHierarchy() {
        [self.headerLabel, self.dateLeftButton, self.boxOfficeDateLabel, self.dateRightButton].forEach { self.addSubview($0) }
    }
    
    private func setAutoLayout() {
        self.headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        self.dateRightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
        }
        
        self.boxOfficeDateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self.dateRightButton.snp.leading)
            make.width.equalTo(110)
        }
        
        self.dateLeftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self.boxOfficeDateLabel.snp.leading)
        }
    }
    
    private func setButtonsAction() {
        self.dateLeftButton.addTarget(self, action: #selector(dateChangeButtonTapped(sender:)), for: .touchUpInside)
        self.dateRightButton.addTarget(self, action: #selector(dateChangeButtonTapped(sender:)), for: .touchUpInside)
    }
    
    @objc private func dateChangeButtonTapped(sender: UIButton) {
        switch sender.tag {
        case -1:
            if self.boxOfficeSelectedDate == .yesterday {
                self.boxOfficeSelectedDate = .theDayBeforeYesterday
            } else if self.boxOfficeSelectedDate == .theDayBeforeYesterday {
                self.boxOfficeSelectedDate = .threeDaysAgo
            } else {
                return
            }
            
        case 1:
            if self.boxOfficeSelectedDate == .threeDaysAgo {
                self.boxOfficeSelectedDate = .theDayBeforeYesterday
            } else if self.boxOfficeSelectedDate == .theDayBeforeYesterday {
                self.boxOfficeSelectedDate = .yesterday
            } else {
                return
            }
            
        default:
            return
            
        }
    }
    
    func withHeaderTitle(_ labelText: String) -> HomeBoxOfficeHeaderView {
        self.headerLabel.text = labelText
        return self
    }
    
    
    
}
