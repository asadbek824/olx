//
//  MainViewController.swift
//  olx
//
//  Created by Asadbek on 21/12/23.
//

import UIKit

final class MainViewController: UIViewController{
    
    //MARK: - UI Elemants
    private let categoriesButton = UIButton()
    private let categoriesView = UIView()
    private let searchController = UISearchController()
    private lazy var  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 82, height: 116)
        layout.minimumLineSpacing = 28
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 22, left: 10, bottom: 22, right: 0)
        
        let collectionViiew = UICollectionView(
            frame: CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width , height: 130 ),
            collectionViewLayout: layout
        )
        categoriesView.backgroundColor = .white
        collectionViiew.showsHorizontalScrollIndicator = false
        collectionViiew.showsVerticalScrollIndicator = false
        collectionViiew.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
        collectionViiew.dataSource = self
        collectionViiew.delegate = self
        
        return collectionViiew
    }()
    private let productView = UIView()
    private lazy var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 162, height: 207)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: 40,
                width: Int(UIScreen.main.bounds.width) - 30,
                height: Int(UIScreen.main.bounds.height) - 350
            ),
            collectionViewLayout: layout
         )
        collectionView.backgroundColor = .rgbAll(243)
 //        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    private let searchBarUI = UISearchBar()
    private let searchView = UIView()
    
    //MARK: - Data
    private var isCancelButtonVisible = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .rgbAll(243)
        
        catigoriesview()
        categories()
        navigationController()
        productview()
        searchBar()
        searchview()
    }
    
    @objc func rightBarButtonBellTapped() {
        
        let notificationViewController = NotificationViewController()
        navigationController?.pushViewController(notificationViewController, animated: true)
    }
    
    @objc func rightBarButtonCancelTapped() {
        
        searchBarUI.resignFirstResponder()
        searchView.isHidden = true
        isCancelButtonVisible = false
        updateRightBarButton()
    }
    
    @objc func categoryCellTap() {
        
        let categorySectionViewController = CategorySectionViewController()
        navigationController?.pushViewController(categorySectionViewController, animated: true)
    }
    
    @objc func productCellTap() {
        
        let productViewController = ProductViewController()
        navigationController?.pushViewController(productViewController, animated: true)
    }
}

// MARK: - Setup CollectionView DelegateFlowLayout && DataSources
extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionView {
            return 10
        }else if collectionView == productCollectionView {
            return 30
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
            
            cell.prepareCell(indexPath: indexPath)
            
            return cell
        }else if collectionView == productCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCell
            
            cell.imageView.image = UIImage(named: "santexnik")
            cell.backgroundColor = .white
            cell.titleLabel.text = "Сантехнические работы"
            cell.timeLabel.text = "Ташкент. Сегодня 11:43"
            cell.priceLabel.text = "от 100 000 сум"
            cell.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.layer.cornerRadius = 10
            
            let cellTap = UITapGestureRecognizer(target: self, action: #selector(productCellTap))
            cell.addGestureRecognizer(cellTap)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoriesViewController = CategoriesViewController()
        navigationController?.pushViewController(categoriesViewController, animated: true)
    }
}

// MARK: - Setup SearchBar Delegate
extension MainViewController: UISearchBarDelegate {
    
    func searchview() {
        
        view.addSubview(searchView)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        searchView.backgroundColor = .white
        searchView.isHidden = true
    }
    
    func searchBar() {
        
        searchBarUI.delegate = self
        navigationItem.titleView = searchBarUI
        
        let rightBarButtonBell = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(rightBarButtonBellTapped))
        rightBarButtonBell.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonBell
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchView.isHidden = false
        isCancelButtonVisible = true
        updateRightBarButton()
    }
    
    func updateRightBarButton() {
        
        if isCancelButtonVisible {
            let rightBarButtonCancel = UIBarButtonItem(title: "Oтмена", style: .plain, target: self, action: #selector(rightBarButtonCancelTapped))
            rightBarButtonCancel.tintColor = .black
            navigationItem.rightBarButtonItem = rightBarButtonCancel
        }else {
            let rightBarButtonBell = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(rightBarButtonBellTapped))
            rightBarButtonBell.tintColor = .black
            navigationItem.rightBarButtonItem = rightBarButtonBell
        }
    }
}

// MARK: - Create UI
private extension MainViewController {
    
    func catigoriesview() {
        
        view.addSubview(categoriesView)
        
        categoriesView.translatesAutoresizingMaskIntoConstraints = false
        categoriesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        categoriesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        categoriesView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        categoriesView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        categoriesView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let lineView = UIView()
        
        categoriesView.addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.leadingAnchor.constraint(equalTo: categoriesView.leadingAnchor, constant: 0).isActive = true
        lineView.trailingAnchor.constraint(equalTo: categoriesView.trailingAnchor, constant: 0).isActive = true
        lineView.topAnchor.constraint(equalTo: categoriesView.topAnchor, constant: 50).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.backgroundColor = .rgbAll(243)
        
        categoriesView.addSubview(collectionView)
    }
    
    func navigationController() {
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    func categories() {
        
        categoriesView.addSubview(categoriesButton)
        
        categoriesButton.translatesAutoresizingMaskIntoConstraints = false
        categoriesButton.leadingAnchor.constraint(equalTo: categoriesView.leadingAnchor, constant: 15).isActive = true
        categoriesButton.trailingAnchor.constraint(equalTo: categoriesView.trailingAnchor, constant: -15).isActive = true
        categoriesButton.topAnchor.constraint(equalTo: categoriesView.topAnchor, constant: 0).isActive = true
        categoriesButton.setTitleColor(.rgbAll(0), for: .normal)
        
//        categoriesButton.addTarget(self, action: #selector(categoriesButtonClicked), for: .touchUpInside)
        
        let categoriesLabel = UILabel()
        let seeAllLabel = UILabel()
        
        categoriesButton.addSubview(categoriesLabel)
        
        categoriesLabel.text = "Категории"
        categoriesLabel.textColor = .rgbAll(0)
        categoriesLabel.font = .systemFont(ofSize: 16)
        categoriesLabel.translatesAutoresizingMaskIntoConstraints = false
        categoriesLabel.leadingAnchor.constraint(equalTo: categoriesButton.leadingAnchor, constant: 0).isActive = true
        categoriesLabel.topAnchor.constraint(equalTo: categoriesButton.topAnchor, constant: 0).isActive = true
        categoriesLabel.bottomAnchor.constraint(equalTo: categoriesButton.bottomAnchor, constant: 0).isActive = true
        
        categoriesButton.addSubview(seeAllLabel)
        
        seeAllLabel.text = "Смотреть все"
        seeAllLabel.textColor = .rgbAll(116)
        seeAllLabel.font = .systemFont(ofSize: 12)
        seeAllLabel.translatesAutoresizingMaskIntoConstraints = false
        seeAllLabel.trailingAnchor.constraint(equalTo: categoriesButton.trailingAnchor, constant: 0).isActive = true
        seeAllLabel.topAnchor.constraint(equalTo: categoriesButton.topAnchor, constant: 1).isActive = true
        seeAllLabel.bottomAnchor.constraint(equalTo: categoriesButton.bottomAnchor, constant: -1).isActive = true
    }
    
    func productview() {
        
        view.addSubview(productView)
        
        productView.translatesAutoresizingMaskIntoConstraints = false
        productView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        productView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        productView.topAnchor.constraint(equalTo: view.topAnchor, constant: 310).isActive = true
        productView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        let titleLabel = UILabel()
        
        productView.addSubview(titleLabel)
        titleLabel.text = "Рекомендованое вам"
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.frame = CGRect(x: 0, y: 10, width: 186, height: 21)
        
        productView.addSubview(productCollectionView)
    }
}
