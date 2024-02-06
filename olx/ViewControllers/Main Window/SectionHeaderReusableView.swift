//
//  SectionHeaderReusableView.swift
//  olx
//
//  Created by Asadbek Yoldoshev on 12/01/24.
//

import UIKit

class SectionHeaderReusableView: UICollectionReusableView {
    
    var sectionType: SectionType?
    
     let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    let buttonSee: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let bottomBorderView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray
            return view
    }()
    
    weak var delegate: SectionHeaderReusableViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleLabel()
        setButtonSee()
        setBottomBorderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func showAllSelected() {
           
        delegate?.didSelectShowAllButton()
//        delegate?.didTapShowAll(forSection: sectionType)
    }
}

extension SectionHeaderReusableView {
    
    private func setTitleLabel() {
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setButtonSee() {
        
        addSubview(buttonSee)
        
        buttonSee.translatesAutoresizingMaskIntoConstraints = false
        buttonSee.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        buttonSee.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        buttonSee.addTarget(self, action: #selector(showAllSelected), for: .touchUpInside)
    }
    
    private func setBottomBorderView() {
        
        addSubview(bottomBorderView)
                
        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        bottomBorderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        bottomBorderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        bottomBorderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorderView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    }
}

