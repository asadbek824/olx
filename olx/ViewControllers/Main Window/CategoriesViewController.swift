//
//  CategoriesViewController.swift
//  olx
//
//  Created by Asadbek on 23/12/23.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .always
        setNavigation()
        tableview()
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cellTapToNextWindow(_ sender: UITapGestureRecognizer) {
        
        if let cell = sender.view as? CategoriesCell, let indexPath = tableView.indexPath(for: cell) {
            
            if indexPath.row != 0 {
                let sectionViewController = CategorySectionViewController()
                
                navigationController?.pushViewController(sectionViewController, animated: true)
            }
        }
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  "cell", for: indexPath) as? CategoriesCell else { return UITableViewCell() }
        
        cell.isUserInteractionEnabled = true
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        
        if indexPath.row == 0 {
            cell.cellView.backgroundColor = .white
            cell.image.backgroundColor = .rgb(0, 47, 52)
            cell.image.image = UIImage(named: "olx1")
            cell.titleLabel.text = "Все обявления"
            cell.resultsLabel.text = "634123 результатов"
        }else {
            cell.cellView.backgroundColor = .rgb(253, 246, 222)
            cell.image.image = UIImage(named: "kalyaska")
            cell.titleLabel.text = "Детский мир"
            cell.resultsLabel.text = "44123 результатов" 
            cell.nextWindowImage.image = UIImage(named: "next")
        }
        
        let cellTap = UITapGestureRecognizer(target: self, action: #selector(cellTapToNextWindow))
        cell.addGestureRecognizer(cellTap)
         
        return cell
    }
    
    func setNavigation() {
        
        navigationItem.title = "Категории"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Отмена", style: .plain, target: self, action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .rgbAll(116)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    func tableview() {
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        tableView.separatorStyle = .none
        tableView.register(CategoriesCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}
