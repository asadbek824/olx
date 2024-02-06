//
//  CategorySectionViewController.swift
//  olx
//
//  Created by Asadbek on 23/12/23.
//

import UIKit

final class CategorySectionViewController: UIViewController {
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
    
        view.backgroundColor = .white
        
        setNavigation()
        tableview()
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension CategorySectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CategoriesCell else { return UITableViewCell() }
        
        cell.isUserInteractionEnabled = true
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0 :
            cell.cellView.backgroundColor = .rgb(253, 246, 222)
            cell.image.image = UIImage(named: "kalyaska")
            cell.titleLabel.text = "Детский мир"
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            cell.titleLabel.frame = CGRect(x: 106, y: 23, width: 119, height: 21)
            cell.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        case 1 :
            cell.titleLabel.text = "Все в Детский мир"
            cell.resultsLabel.text = "44123 результатов"
            cell.titleLabel.frame = CGRect(x: 0, y: 20, width: 150, height: 14)
            cell.titleLabel.font = .systemFont(ofSize: 14)
            cell.resultsLabel.frame = CGRect(x: 0, y: 40, width: 150, height: 14)
            cell.resultsLabel.font = .systemFont(ofSize: 11)
            cell.image.isHidden = true
        default :
            cell.titleLabel.text = "Детский мир"
            cell.resultsLabel.text = "44123 результатов"
            cell.titleLabel.frame = CGRect(x: 0, y: 20, width: 150, height: 14)
            cell.titleLabel.font = .systemFont(ofSize: 14)
            cell.resultsLabel.frame = CGRect(x: 0, y: 40, width: 150, height: 14)
            cell.resultsLabel.font = .systemFont(ofSize: 11)
            cell.image.isHidden = true
            cell.nextWindowImage.image = UIImage(named: "next")
        }
        
        
        
        return cell
    }
    
    func setNavigation() {
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .rgbAll(116)
        navigationItem.title = "Категория"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func tableview() {
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        tableView.register(CategoriesCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}
