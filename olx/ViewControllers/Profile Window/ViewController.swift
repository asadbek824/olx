//
//  ViewController.swift
//  olx
//
//  Created by Asadbek on 19/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - UIElements
    private let segmentedControll = UISegmentedControl()
    private let access = AccessUIView()
    private let signUp = SignUpUIView()
    
    private let viewsWidth = UIScreen.main.bounds.width - 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(tappedToView))
        )
        
        setNavigation()
        setupSegmentedController()
        accessView()
        signUpView()
        
    }
    
    //MARK: - Methods
    @objc func tappedToView() {
        view.endEditing(true)
    }
    
    @objc func changeView() {
        access.isHidden = segmentedControll.selectedSegmentIndex == 1
        signUp.isHidden = segmentedControll.selectedSegmentIndex == 0
    }
}

//MARK: - Extensions
extension ViewController {
    
    func setNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Создать"
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupSegmentedController() {
        view.addSubview(segmentedControll)
        
        segmentedControll.frame = CGRect(x: 15, y: 175, width: viewsWidth, height: 31)
        segmentedControll.insertSegment(withTitle: "Войти", at: 0, animated: false)
        segmentedControll.insertSegment(withTitle: "Зарегистроваться", at: 1, animated: false)
        segmentedControll.selectedSegmentIndex = 0
        segmentedControll.addTarget(self, action: #selector(changeView), for: .valueChanged)
    }
    
    func accessView() {
        
        view.addSubview(access)
        
        access.translatesAutoresizingMaskIntoConstraints = false
        access.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        access.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        access.topAnchor.constraint(equalTo: view.topAnchor, constant: 230).isActive = true
        access.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func signUpView() {
        
        view.addSubview(signUp)
        
        signUp.isHidden = true
        signUp.translatesAutoresizingMaskIntoConstraints = false
        signUp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        signUp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        signUp.topAnchor.constraint(equalTo: view.topAnchor, constant: 230).isActive = true
        signUp.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true    }
}

extension UIColor {
    
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static func rgbAll(_ value: CGFloat) -> UIColor {
        UIColor(red: value/255, green: value/255, blue: value/255, alpha: 1)
    }
}

