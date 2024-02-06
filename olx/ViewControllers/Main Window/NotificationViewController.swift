//
//  NotificationViewController.swift
//  olx
//
//  Created by Asadbek on 05/01/24.
//

import UIKit

final class NotificationViewController: UIViewController {
    
    override func viewDidLoad() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
        view.backgroundColor = .white
    }
    
    @objc func leftBarButtonTapped() {
        
        navigationController?.popViewController(animated: true)
    }
}
