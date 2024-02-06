//
//  CategoriesCell.swift
//  olx
//
//  Created by Asadbek on 23/12/23.
//

import UIKit

final class CategoriesCell: UITableViewCell {
    
    let cellView = UIView()
    let titleLabel = UILabel()
    let image = UIImageView()
    let resultsLabel = UILabel()
    let nextWindowImage = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:  style, reuseIdentifier: reuseIdentifier)
        
        cellview()
        titlelabel()
        imageview()
        resultslabel()
        nextWindowimage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CategoriesCell {
    
    func cellview() {
        
        contentView.addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        cellView.layer.cornerRadius = 5
    }
    
    func titlelabel() {
        
        cellView.addSubview(titleLabel)

        titleLabel.frame = CGRect(x: 106, y: 9, width: 200, height: 20)
        titleLabel.font = .systemFont(ofSize: 14)
    }
    
    func imageview() {
        
        cellView.addSubview(image)

        image.frame = CGRect(x: 15, y: 5, width: 60, height: 60)
        image.layer.cornerRadius = 30
        image.backgroundColor = .rgb(255, 206, 50)
    }
    
    func resultslabel() {
        
        cellView.addSubview(resultsLabel)

        resultsLabel.frame = CGRect(x: 106, y: 29, width: 200, height: 20)
        resultsLabel.font = .systemFont(ofSize: 11)
        resultsLabel.textColor = .rgbAll(79)
    }
    
    func nextWindowimage() {
        
        cellView.addSubview(nextWindowImage)

        nextWindowImage.translatesAutoresizingMaskIntoConstraints = false
        nextWindowImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15).isActive = true
        nextWindowImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 24).isActive = true
        nextWindowImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -24).isActive = true
    }
}
