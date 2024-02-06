//
//  MainViewController2.swift
//  olx
//
//  Created by Asadbek on 08/01/24.
//

import UIKit

struct CollectionData {
    
    let image: UIImage
    let title: String
    let address: String
    let price: String
}

enum SectionType: Int, CaseIterable {
    case category = 0
    case recomendation = 1
}

protocol SectionHeaderReusableViewDelegate: NSObject {
    func didSelectShowAllButton()
    func didTapShowAll(forSection section: SectionType)
}

final class MainViewController2: UIViewController {
    
    //MARK: - UI Elemants
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private lazy var collectionView: UICollectionView = {
        let collectionViiew = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionViiew.showsHorizontalScrollIndicator = false
        collectionViiew.showsVerticalScrollIndicator = false
        collectionViiew.register(CategoryCell.self, forCellWithReuseIdentifier: "cell1")
        collectionViiew.register(ProductCell.self, forCellWithReuseIdentifier: "cell2")
        collectionViiew.register(SectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        collectionViiew.dataSource = self
        collectionViiew.backgroundColor = .rgbAll(243)
        collectionViiew.delegate = self
        
        return collectionViiew
    }()
    
    //MARK: - Data
    private let collectionData: [CollectionData] = [
        CollectionData.init(image: UIImage(named: "15promax")!, title: "iPhone 15 Pro Max", address: "Ташкент. Сегодня 9:41", price: "999.99$"),
        CollectionData.init(image: UIImage(named: "14promax")!, title: "iPhone 14 Pro Max", address: "Ташкент. Сегодня 9:41", price: "899.99$"),
        CollectionData.init(image: UIImage(named: "malibu2")!, title: "Malibu 2 Premyer", address: "Ташкент. Сегодня 9:41", price: "29 999$"),
        CollectionData.init(image: UIImage(named: "gentra")!, title: "Gentra 1.5", address: "Ташкент. Сегодня 9:41", price: "16 999$"),
        CollectionData.init(image: UIImage(named: "santexnik")!, title: "Сантехнические работы", address: "Ташкент. Сегодня 9:41", price: "от 100 000 сум"),
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Home View"
        navigationItem.largeTitleDisplayMode = .never
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        let rightBarButtonBell = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(rightBarButtonBellTapped))
        rightBarButtonBell.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonBell
        navigationItem.searchController = searchController
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        view.addSubview(collectionView)
        
        collectionView.setConstraint(.top, from: view, 0)
        collectionView.setConstraint(.bottom, from: view, 0)
        collectionView.setConstraint(.left, from: view, 0)
        collectionView.setConstraint(.right, from: view, 0)
        
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, s: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            
            if sectionIndex == SectionType.category.rawValue {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .estimated(140))
                let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
//                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .groupPagingCentered
//                section.contentInsets = .init(top: 22, leading: 10, bottom: 22, trailing: 0)
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let item2 = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                item2.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(220))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item2])
                
                section = NSCollectionLayoutSection(group: group)
            }
            
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        
        return layout
    }
    
    @objc func rightBarButtonBellTapped() {
        
        let notificationViewController = NotificationViewController()
        navigationController?.pushViewController(notificationViewController, animated: true)
    }
    
    @objc func buttonSeeTapped() {
        
        let categoriesViewController = UINavigationController(rootViewController: CategoriesViewController())
        categoriesViewController.modalPresentationStyle = .fullScreen
        present(categoriesViewController, animated: true)
    }
}

extension MainViewController2: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { SectionType.allCases.count }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { collectionData.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == SectionType.category.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CategoryCell
            
            cell.prepareCell(indexPath: indexPath)
            cell.backgroundColor = .white
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! ProductCell
            
            if indexPath.row < collectionData.count {
                let data = collectionData[indexPath.row]
                cell.configure(data: data)
                cell.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
                cell.heartButton.tintColor = .black
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == SectionType.category.rawValue {
            if indexPath.row == 0 {
                let categoriesViewController = CategoriesViewController()
                navigationController?.pushViewController(categoriesViewController, animated: true)
            } else {
                let categorySectionViewController = CategorySectionViewController()
                navigationController?.pushViewController(categorySectionViewController, animated: true)
            }
        } else {
            let productViewController = ProductViewController()
            navigationController?.pushViewController(productViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader,
           let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath
           ) as? SectionHeaderReusableView {
            headerView.titleLabel.text = indexPath.section == SectionType.category.rawValue ? "Категории" : "Рекомендации"
            headerView.buttonSee.setTitle(indexPath.section == SectionType.category.rawValue ? "Смотреть все" : "", for: .normal)
            headerView.buttonSee.addTarget(self, action: #selector(buttonSeeTapped), for: .touchUpInside)
            headerView.buttonSee.isHidden = indexPath.section != SectionType.category.rawValue
            headerView.bottomBorderView.isHidden = indexPath.section != SectionType.category.rawValue
            headerView.delegate = self
            headerView.backgroundColor = indexPath.section == SectionType.category.rawValue ? .white : .rgbAll(243)
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
}

extension MainViewController2: SectionHeaderReusableViewDelegate {
    
    func didTapShowAll(forSection section: SectionType) {
        
    }
    
    func didSelectShowAllButton() {
//        let categoriesViewController = UINavigationController(rootViewController: CategoriesViewController())
//        categoriesViewController.modalPresentationStyle = .fullScreen
//        present(categoriesViewController, animated: true)
    }
}

extension MainViewController2: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if (searchController.searchBar.text?.lowercased()) != nil {
            // Filter your data based on the searchText
            // Update your UI with the filtered results
        }
    }
}

