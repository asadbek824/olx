//
//  SignUpUIView.swift
//  olx
//
//  Created by Asadbek on 21/12/23.
//

import UIKit

final class SignUpUIView: UIView {
    
    //MARK: - UIElements
    private let continueWithApple = UIButton(type: .system)
    private let andView = UIView()
    private let gmailLabel = UILabel()
    private let gmailTextFiled = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let passwordRequirementLabel = UILabel()
    private let confirmationButton = UIButton(type: .system)
    private let confirmationLabel = UILabel()
    private let registrationButton = UIButton(type: .system)
    
    private let viewsWidth = UIScreen.main.bounds.width - 30
    private var isSecureTextEntry = true
    private var isConfirmed:Bool = false
    
    init(){
        super.init(frame: .zero)
        
        continueApple()
        andLine()
        setupGmail()
        setupPassword()
        passwordRequirement()
        confirmation()
        confirmationCondition()
        registration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    @objc func showTapped() {
        isSecureTextEntry.toggle()
        passwordTextField.isSecureTextEntry = isSecureTextEntry
    }
    
    @objc func checkImageInTapped(_ sender: UIButton) {
        
        if isConfirmed {
            sender.setImage(nil, for: .normal)
        }else {
            let checkImage = UIImage(systemName: "checkmark")
            UIView.transition(with: sender, duration: 0.5, options: .transitionCrossDissolve, animations: {
                        sender.setImage(checkImage, for: .normal)
            }, completion: nil)
        }
        isConfirmed.toggle()
    }
}

//MARK: - Extensions
extension SignUpUIView {
    
    func continueApple() {
        
        let appleLogoView = UIView()
        
        addSubview(continueWithApple)
        
        continueWithApple.frame = CGRect(x: 0, y: 0, width: viewsWidth, height: 45)
        continueWithApple.layer.cornerRadius = 5
        continueWithApple.layer.borderWidth = 1
        continueWithApple.setTitle("Продолжить с Apple", for: .normal)
        continueWithApple.setTitleColor(.rgb(0, 47, 52), for: .normal)
        continueWithApple.titleLabel?.font = .systemFont(ofSize: 15)
        
        continueWithApple.addSubview(appleLogoView)
        
        appleLogoView.frame = CGRect(x: 49, y: 12, width: 15, height: 19)
        appleLogoView.backgroundColor = UIColor(patternImage: UIImage(systemName: "applelogo")!)
    }
    
    func andLine() {
        addSubview(andView)
        
        andView.frame = CGRect(x: 0, y: 83, width: (viewsWidth / 2) - 15, height: 1)
        andView.backgroundColor = .rgbAll(196)
        
        let andLine = UILabel()
        let viewAnd = UIView()
        
        addSubview(andLine)
        
        andLine.text = "или"
        andLine.font = .systemFont(ofSize: 15)
        andLine.textColor = .rgb(0, 47, 52)
        andLine.frame = CGRect(x: (Int(viewsWidth) / 2) , y: 72, width: 30, height: 18)
        
        addSubview(viewAnd)
        
        viewAnd.frame = CGRect(x: 35 + viewsWidth / 2, y: 83, width: (viewsWidth / 2) - 30, height: 1)
        viewAnd.backgroundColor = .rgbAll(196)
    }
    
    func setupGmail() {
        addSubview(gmailLabel)
        
        gmailLabel.frame = CGRect(x: 0, y: 118, width: viewsWidth, height: 14)
        gmailLabel.text = "Электронная почта или телефон"
        gmailLabel.font = .systemFont(ofSize: 12)
        gmailLabel.textColor = .rgb(0, 47, 52)
        
        addSubview(gmailTextFiled)
        
        gmailTextFiled.frame = CGRect(x: 0, y: 140, width: viewsWidth, height: 45)
        gmailTextFiled.placeholder = "Введите вашу почту или номер телефона"
        gmailTextFiled.textAlignment = .center
        gmailTextFiled.backgroundColor = .rgbAll(243)
        gmailTextFiled.layer.cornerRadius = 5
    }
    
    func setupPassword() {
        addSubview(passwordLabel)
        
        passwordLabel.frame = CGRect(x: 0, y:  198, width: viewsWidth, height: 14)
        passwordLabel.text = "Пароль"
        passwordLabel.font = .systemFont(ofSize: 12)
        passwordLabel.textColor = .rgb(0, 47, 52)
        
        addSubview(passwordTextField)
        
        passwordTextField.frame = CGRect(x: 0, y: 220, width: viewsWidth, height: 45)
        passwordTextField.placeholder = "Введите ваш пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textAlignment = .center
        passwordTextField.backgroundColor = .rgbAll(243)
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.rightViewMode = .always
        
        let showSecure = UIButton(type: .system)
        
        passwordTextField.addSubview(showSecure)
        
        showSecure.setTitle("Показать", for: .normal)
        showSecure.setTitleColor(.rgb(0, 47, 52), for: .normal)
        showSecure.addTarget(self, action: #selector(showTapped), for: .touchUpInside)
        passwordTextField.rightView = showSecure
    }
    
    func passwordRequirement() {
        
        addSubview(passwordRequirementLabel)
        
        passwordRequirementLabel.frame = CGRect(x: 0, y: 280, width: viewsWidth, height: 43)
        passwordRequirementLabel.text = "Пароль дольжен содержать минимум 6 симболов. Чтобы пароль получился супернадежными, добавьте заглавные и строчные буквы, цыфры и специальные символы"
        passwordRequirementLabel.textColor = .rgbAll(0)
        passwordRequirementLabel.font = .systemFont(ofSize: 12)
        passwordRequirementLabel.numberOfLines = 0
        passwordRequirementLabel.lineBreakMode = .byWordWrapping
    }
    
    func confirmation() {
        
        addSubview(confirmationButton)
        
        confirmationButton.frame = CGRect(x: 0, y: 342, width: 24, height: 24)
        confirmationButton.layer.cornerRadius = 5
        confirmationButton.layer.borderWidth = 2
        confirmationButton.layer.borderColor = UIColor.rgb(0, 47, 52).cgColor
        
        confirmationButton.addTarget(self, action: #selector(checkImageInTapped), for: .touchUpInside)
    }
    
    func confirmationCondition() {
        
        addSubview(confirmationLabel)
        
        confirmationLabel.frame = CGRect(x: 36, y: 330, width: Int(viewsWidth) - 30, height: 60)
        confirmationLabel.text = "Я соглащаюсь с правилами использования сервиса, а также с передачей и обработкой моих данных в OLX. Я подверждаю свое совершеннолетие и отвественность за размещение объявления"
        confirmationLabel.font = .systemFont(ofSize: 12)
        confirmationLabel.numberOfLines = 0
        confirmationLabel.lineBreakMode = .byWordWrapping
    }
    
    func registration() {
        
        addSubview(registrationButton)
        
        registrationButton.frame = CGRect(x: 0, y: 408, width: viewsWidth, height: 45)
        registrationButton.layer.cornerRadius = 5
        registrationButton.backgroundColor = .rgb(0, 47, 52)
        registrationButton.setTitle("Зарегистроваться", for: .normal)
        registrationButton.setTitleColor(.rgbAll(255), for: .normal)
    }
}
