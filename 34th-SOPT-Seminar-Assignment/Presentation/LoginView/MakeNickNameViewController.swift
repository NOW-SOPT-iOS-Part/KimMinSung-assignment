//
//  MakeNicknameViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/16.
//

import UIKit

class MakeNicknameViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 23, weight: 500)
        label.textAlignment = .left
        label.textColor = .white
        label.text = "닉네임을 입력해주세요"
        return label
    }()
    
    let nicknameTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.pretendardFont(ofSize: 14, weight: 600)
        tf.backgroundColor = UIColor(named: "gray3")
        tf.textColor = .white
        tf.leftViewMode = .always
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 3
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 10))
        return tf
    }()
    
    lazy var saveNicknameButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장하기", for: UIControl.State.normal)
        button.backgroundColor = UIColor(named: "TVING_Red")
        button.titleLabel?.font = UIFont.pretendardFont(ofSize: 14, weight: 600)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.cornerCurve = .continuous
        button.addTarget(self, action: #selector(saveNicknameButtonDidTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gray4")
        self.configureHiearchy()
        self.setLayout()
        self.textFieldInitialSetup()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.view.endEditing(true)
    }
    
    private func configureHiearchy() {
        [self.titleLabel, self.nicknameTextField, self.saveNicknameButton].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    private func setLayout() {
        [self.titleLabel, self.nicknameTextField, self.saveNicknameButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.titleLabel.snp.makeConstraints { label in
            label.top.equalToSuperview().offset(50)
            label.leading.equalToSuperview().offset(20)
        }
        
        self.nicknameTextField.snp.makeConstraints { tf in
            tf.top.equalTo(self.titleLabel.snp.bottom).offset(21)
            tf.leading.equalToSuperview().offset(20)
            tf.trailing.equalToSuperview().offset(-20)
            tf.height.equalTo(52)
        }
        
        self.saveNicknameButton.snp.makeConstraints { btn in
            btn.leading.equalToSuperview().offset(25)
            btn.trailing.equalToSuperview().offset(-25)
            btn.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            btn.height.equalTo(52)
        }
    }
    
    private func textFieldInitialSetup() {
        //guard let loginView = self.presentingViewController as? LoginViewController else { fatalError() }
        guard let loginView = self.presentingViewController as? LoginViewControllerType else { fatalError() }
        guard let nickName = loginView.nickname else { return }
        self.nicknameTextField.text = nickName
    }
    
    private func checkIfValidNickName(string: String) -> Bool {
        let nickNameRegEx = "^[가-힣]{1,10}$"
        if string.range(of: nickNameRegEx, options: .regularExpression) != nil {
            return true
        } else {
            return false
        }
    }
    
    @objc private func saveNicknameButtonDidTapped() {
        print(#function)
        let newNickname = self.nicknameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if newNickname.isEmpty {
            let alertCon = UIAlertController(title: "닉네임 이름이 비었습니다.", message: "닉네임을 입력한 후\n저장 버튼을 누르세요.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "이게 아요야", style: UIAlertAction.Style.default)
            alertCon.addAction(okAction)
            self.present(alertCon, animated: true)
            
        } else if !checkIfValidNickName(string: newNickname) {
            let alertCon = UIAlertController(title: "올바른 형식이 아닙니다.", message: "닉네임은 1~10자의 한글로만 구성되어야 합니다.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "이게 아요야", style: UIAlertAction.Style.default)
            alertCon.addAction(okAction)
            self.present(alertCon, animated: true)
            
        } else {
            guard let loginVC = self.presentingViewController as? LoginViewController else { fatalError() }
            loginVC.nickname = newNickname
            self.dismiss(animated: true)
        }
        
    }
    
    
    
}
