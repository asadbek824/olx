//
//  CategoryCell.swift
//  olx
//
//  Created by Asadbek on 02/01/24.
//

import UIKit
 
final class CategoryCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageview()
        titlelabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCell(indexPath: IndexPath) {
        if indexPath.row == 0 {
            imageView.image = UIImage(named: "olxCurcle")
            titleLabel.text = "Все обявления"
        } else{
            imageView.image = UIImage(named: "kalyaska")
            imageView.backgroundColor = .rgb(255, 206, 50)
            titleLabel.text = "Десткий мир"
        }
    }
}

extension CategoryCell {
    
    func imageview() {
        
        contentView.addSubview(imageView)
        imageView.frame = CGRect(x: 10, y: 10, width: 82, height: 82)
        imageView.layer.cornerRadius = 41
    }
    
    func titlelabel() {
        
        contentView.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 10, y: 100, width: 82, height: 30)
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.numberOfLines = 0
    }
}
