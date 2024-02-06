//
//  AccessUIView.swift
//  olx
//
//  Created by Asadbek on 21/12/23.
//

import UIKit

final class AccessUIView: UIView {
    
    //MARK: - UIElements
    private let gmailLabel = UILabel()
    private let gmailTextFiled = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let forgotButton = UIButton(type: .system)
    private let accessButton = UIButton(type: .system)
    private let andView = UIView()
    private let termsOfUseButton = UIButton(type: .system)
    
    private let viewsWidth = UIScreen.main.bounds.width - 30
    private var isSecureTextEntry = true
    
    init() {
        super.init(frame: .zero)
        
        setupGmail()
        setupPassword()
        forgotPassword()
        accsess()
        andLine()
        termsOfUse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    @objc func showTapped() {
        isSecureTextEntry.toggle()
        passwordTextField.isSecureTextEntry = isSecureTextEntry
    }
}

//MARK: - Extensions
extension AccessUIView {
    
    func setupGmail() {
        addSubview(gmailLabel)
        
        gmailLabel.frame = CGRect(x: 0, y: 0, width: viewsWidth, height: 14)
        gmailLabel.text = "Электронная почта или телефон"
        gmailLabel.font = .systemFont(ofSize: 12)
        gmailLabel.textColor = .rgb(0, 47, 52)
        
        addSubview(gmailTextFiled)
        
        gmailTextFiled.frame = CGRect(x: 0, y: 22, width: viewsWidth, height: 45)
        gmailTextFiled.placeholder = "Введите вашу почту или номер телефона"
        gmailTextFiled.textAlignment = .center
        gmailTextFiled.backgroundColor = .rgbAll(243)
        gmailTextFiled.layer.cornerRadius = 5
    }
    
    func setupPassword() {
        addSubview(passwordLabel)
        
        passwordLabel.frame = CGRect(x: 0, y:  80, width: viewsWidth, height: 14)
        passwordLabel.text = "Пароль"
        passwordLabel.font = .systemFont(ofSize: 12)
        passwordLabel.textColor = .rgb(0, 47, 52)
        
        addSubview(passwordTextField)
        
        passwordTextField.frame = CGRect(x: 0, y: 102, width: viewsWidth, height: 45)
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
    
    func forgotPassword() {
        addSubview(forgotButton)
        
        forgotButton.frame = CGRect(x: 0, y: 170, width: 100, height: 14)
        forgotButton.setTitle("Забыли пароль", for: .normal)
        forgotButton.setTitleColor(UIColor.rgb(0, 47, 52), for: .normal)
        forgotButton.titleLabel?.font = .systemFont(ofSize: 12)
    }
    
    func accsess() {
        addSubview(accessButton)
        
        accessButton.frame = CGRect(x: 0, y: 192, width: viewsWidth, height: 45)
        accessButton.backgroundColor = .rgb(0, 47, 52)
        accessButton.layer.cornerRadius = 5
        accessButton.setTitle("Войти", for: .normal)
        accessButton.setTitleColor(.rgbAll(255), for: .normal)
        accessButton.titleLabel?.font = .systemFont(ofSize: 15)
        
        let continueWithAppleButton = UIButton(type: .system)
        let appleLogoView = UIView()
        
        addSubview(continueWithAppleButton)
        
        continueWithAppleButton.frame = CGRect(x: 0, y: 311, width: viewsWidth, height: 45)
        continueWithAppleButton.layer.cornerRadius = 5
        continueWithAppleButton.layer.borderWidth = 1
        continueWithAppleButton.setTitle("Продолжить с Apple", for: .normal)
        continueWithAppleButton.setTitleColor(.rgb(0, 47, 52), for: .normal)
        continueWithAppleButton.titleLabel?.font = .systemFont(ofSize: 15)
        
        continueWithAppleButton.addSubview(appleLogoView)
        
        appleLogoView.frame = CGRect(x: 49, y: 12, width: 15, height: 19)
        appleLogoView.backgroundColor = UIColor(patternImage: UIImage(systemName: "applelogo")!)
    }
    
    func andLine() {
        addSubview(andView)
        
        andView.frame = CGRect(x: 0, y: 275, width: (viewsWidth / 2) - 15, height: 1)
        andView.backgroundColor = .rgbAll(196)
        
        let andLine = UILabel()
        let viewAnd = UIView()
        
        addSubview(andLine)
        
        andLine.text = "или"
        andLine.font = .systemFont(ofSize: 15)
        andLine.textColor = .rgb(0, 47, 52)
        andLine.frame = CGRect(x: (Int(viewsWidth) / 2) , y: 264, width: 30, height: 18)
        
        addSubview(viewAnd)
        
        viewAnd.frame = CGRect(x: 35 + viewsWidth / 2, y: 275, width: (viewsWidth / 2) - 30, height: 1)
        viewAnd.backgroundColor = .rgbAll(196)
    }
    
    func termsOfUse() {
        addSubview(termsOfUseButton)
        
        termsOfUseButton.frame = CGRect(x: (Int(viewsWidth) / 2) - 100, y: 381, width: 250, height: 20)
        termsOfUseButton.setTitle("При входе вы соглашаетесь с нашими \nУсловиями использования", for: .normal)
        termsOfUseButton.setTitleColor(.rgbAll(30), for: .normal)
        termsOfUseButton.titleLabel?.font = .systemFont(ofSize: 12)
        termsOfUseButton.titleLabel?.numberOfLines = 0
        termsOfUseButton.titleLabel?.lineBreakMode = .byWordWrapping
        termsOfUseButton.titleLabel?.textAlignment = .center
    }
}

