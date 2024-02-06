//
//  ProductViewController.swift
//  olx
//
//  Created by Asadbek on 05/01/24.
//

import UIKit

final class ProductViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let backButton = UIButton(type: .system)
    private let heartButton = UIButton(type: .system)
    private let infoView = UIView()
    private let leaveFeedbackButton = UIButton(type: .system)
    private let allAuthorsButton = UIButton(type: .system)
    private let lineView = UIView()
    private let similarAdvertisementsView = UIView()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
         )
        collectionView.backgroundColor = .rgbAll(243)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(
            SectionHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionHeader"
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    private var checkThePressure = true
    private var isTurn = true
    
    override func viewDidLoad() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .rgbAll(243)
        
        imageview()
        infoview()
        updateButtonState()
        setUpBackButton()
        setUpHeartButton()
        setUpCollectionView()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(170), heightDimension: .absolute(210))
            let group:NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = .init(top: 10, leading: 10, bottom: 0, trailing: 10)
            
            section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .continuous
            
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        return layout
    }
    
    @objc private func leaveFeedbackButtonTapped() {
        
        checkThePressure = true
        updateButtonState()
    }
    
    @objc private func allAuthorsButtonTapped() {
        
        checkThePressure = false
        updateButtonState()
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func heartButtonTapped(_ sender: UIButton) {
        
        if isTurn {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            sender.tintColor = .red
        } else {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            sender.tintColor = .white
        }
        isTurn.toggle()
    }
}

extension ProductViewController {
    
    private func imageview() {
        
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3.5).isActive = true
        imageView.image = UIImage(named: "santexnik1")
    }
    
    private func setUpBackButton() {
        
        view.addSubview(backButton)
        
        backButton.setConstraint(.top, from: view, 50)
        backButton.setConstraint(.left, from: view, 20)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = .white
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setUpHeartButton() {
        
        view.addSubview(heartButton)
        
        heartButton.setConstraint(.top, from: view, 50)
        heartButton.setConstraint(.right, from: view, 20)
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = .white
        
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }
    
    private func infoview() {
        
        view.addSubview(infoView)
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.topAnchor.constraint(equalTo: view.topAnchor, constant: (UIScreen.main.bounds.height / 3.5) - 10).isActive = true
        infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        infoView.backgroundColor = .white
        infoView.layer.cornerRadius = 10
        
        let timeLabel = UILabel()
        let serviceTypeLabel = UILabel()
        let servicePriceLabel = UILabel()
        let descriptionLabel = UILabel()
        let infoLabel = UILabel()
        let nameLabel = UILabel()
        let timeEnteredLabel = UILabel()
        
        infoView.addSubview(timeLabel)
        
        timeLabel.frame = CGRect(x: 16, y: 12, width: 75, height: 12)
        timeLabel.font = .systemFont(ofSize: 10)
        timeLabel.text = "Сегодня, 10:29"
        timeLabel.textColor = .rgbAll(116)
        
        infoView.addSubview(serviceTypeLabel)
        
        serviceTypeLabel.frame = CGRect(x: 16, y: 27, width: 371, height: 20)
        serviceTypeLabel.font = .systemFont(ofSize: 18)
        serviceTypeLabel.text = "Сантехнические работы"
        
        infoView.addSubview(servicePriceLabel)
        
        servicePriceLabel.frame = CGRect(x: 16, y: 53, width: 371, height: 20)
        servicePriceLabel.font = .boldSystemFont(ofSize: 22)
        servicePriceLabel.text = "от 100 000 сум"
        
        infoView.addSubview(descriptionLabel)
        
        descriptionLabel.frame = CGRect(x: 16, y: 97, width: 371, height: 20)
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.text = "Описание"
        
        infoView.addSubview(infoLabel)
        
        infoLabel.frame = CGRect(x: 16, y: 120, width: 371, height: 38)
        infoLabel.numberOfLines = 0
        infoLabel.font = .systemFont(ofSize: 12)
        infoLabel.text = "Сантехнические услуги 24/7 по городу Ташкент и Ташкенсткой области. +998 71 123 45 67"
        
        infoView.addSubview(nameLabel)
        
        nameLabel.frame = CGRect(x: 16, y: 171, width: 371, height: 20)
        nameLabel.font = .boldSystemFont(ofSize: 18)
        nameLabel.text = "Алишер"
        
        infoView.addSubview(timeEnteredLabel)
        
        timeEnteredLabel.frame = CGRect(x: 16, y: 197, width: 371, height: 20)
        timeEnteredLabel.font = .systemFont(ofSize: 10)
        timeEnteredLabel.textColor = .rgbAll(79)
        timeEnteredLabel.text = "Онлайн в 12:02"
        
        infoView.addSubview(leaveFeedbackButton)
        
        leaveFeedbackButton.translatesAutoresizingMaskIntoConstraints = false
        leaveFeedbackButton.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 225).isActive = true
        leaveFeedbackButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 16).isActive = true
        leaveFeedbackButton.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: (-UIScreen.main.bounds.width / 2) - 10).isActive = true
        leaveFeedbackButton.heightAnchor.constraint(equalToConstant: 39).isActive = true
        leaveFeedbackButton.setTitle("Оставить отзыв", for: .normal)
        leaveFeedbackButton.setTitleColor(.rgb(0, 47, 52), for: .normal)
        leaveFeedbackButton.titleLabel?.font = .systemFont(ofSize: 13)
        leaveFeedbackButton.layer.cornerRadius = 5
        leaveFeedbackButton.addTarget(self, action: #selector(leaveFeedbackButtonTapped), for: .touchUpInside)
        
        infoView.addSubview(allAuthorsButton)
        
        allAuthorsButton.translatesAutoresizingMaskIntoConstraints = false
        allAuthorsButton.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 225).isActive = true
        allAuthorsButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: (UIScreen.main.bounds.width / 2) + 10).isActive = true
        allAuthorsButton.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -16).isActive = true
        allAuthorsButton.heightAnchor.constraint(equalToConstant: 39).isActive = true
        allAuthorsButton.setTitle("Все объявления автора", for: .normal)
        allAuthorsButton.titleLabel?.font = .systemFont(ofSize: 13)
        allAuthorsButton.setTitleColor(.rgb(0, 47, 52), for: .normal)
        allAuthorsButton.layer.cornerRadius = 5
        allAuthorsButton.addTarget(self, action: #selector(allAuthorsButtonTapped), for: .touchUpInside)
    }
    
    private func updateButtonState() {
        UIView.animate(withDuration: 0.3) {
            self.leaveFeedbackButton.layer.borderWidth = self.checkThePressure ? 0 : 1
            self.allAuthorsButton.layer.borderWidth = self.checkThePressure ? 1 : 0
            
            self.lineView.removeFromSuperview()
            
            self.infoView.addSubview(self.lineView)
            
            self.lineView.translatesAutoresizingMaskIntoConstraints = false
            if self.checkThePressure {
                self.lineView.leadingAnchor.constraint(equalTo: self.infoView.leadingAnchor, constant: 16).isActive = true
                self.lineView.trailingAnchor.constraint(equalTo: self.infoView.centerXAnchor, constant: -10).isActive = true
            } else {
                self.lineView.leadingAnchor.constraint(equalTo: self.infoView.centerXAnchor, constant: 10).isActive = true
                self.lineView.trailingAnchor.constraint(equalTo: self.infoView.trailingAnchor, constant: -16).isActive = true
            }
            
            self.lineView.topAnchor.constraint(equalTo: self.infoView.topAnchor, constant: 255).isActive = true
            self.lineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
            self.lineView.backgroundColor = .rgb(0, 47, 52)
            
            self.infoView.layoutSubviews()
        }
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 10 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCell
        
        cell.imageView.setConstraint(.height, from: UIView(), 99.54)
        cell.imageView.image = UIImage(named: "santexnik")
        cell.backgroundColor = .white
        cell.titleLabel.text = "Сантехнические работы"
        cell.timeLabel.text = "Ташкент. Сегодня 11:43"
        cell.priceLabel.text = "от 100 000 сум"
        cell.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productViewController = ProductViewController()
        navigationController?.pushViewController(productViewController, animated: true)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
         ofKind: kind,
         withReuseIdentifier: "SectionHeader",
         for: indexPath
        ) as? SectionHeaderReusableView else { return collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) }
        
        header.titleLabel.text = "Похожие объявления"
        header.buttonSee.isHidden = true
        header.bottomBorderView.isHidden = true
        
        return header
    }
    
    private func setUpCollectionView() {
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 5).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
}
