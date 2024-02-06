//
//  ProductCell.swift
//  olx
//
//  Created by Asadbek on 03/01/24.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    
    // MARK: UI Elements
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let timeLabel = UILabel()
    let heartButton = UIButton(type: .system)
    
    // MARK: Data
    private var isTurn = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageview()
        titlelabel()
        timelabel()
        pricelabel()
        heartbutton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: CollectionData) {
        imageView.image = data.image
        titleLabel.text = data.title
        timeLabel.text = data.address
        priceLabel.text = data.price
    }
    
    @objc func heartButtonTapped(_ sender: UIButton) {
        
        if isTurn {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            sender.tintColor = .red
            
            let cloneButton = UIButton(type: .custom)
            cloneButton.frame = heartButton.frame
            cloneButton.setTitle(heartButton.title(for: .normal), for: .normal)
            cloneButton.tintColor = .red
            cloneButton.backgroundColor = heartButton.backgroundColor
            cloneButton.layer.cornerRadius = heartButton.layer.cornerRadius
            cloneButton.setImage(heartButton.image(for: .normal), for: .normal)
            
            self.addSubview(cloneButton)
            
            let animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1) {
                cloneButton.transform = CGAffineTransform(translationX: -45, y: -10)
            }
            
            // Запустите анимацию
            animator.startAnimation()
            
            // По завершении первой анимации выполните вторую
            animator.addCompletion { (_) in
                UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    cloneButton.alpha = 1
                    cloneButton.transform = cloneButton.transform.translatedBy(x: -10, y: 300)
                }, completion: { _ in
                    cloneButton.removeFromSuperview() // Удалить клон после завершения второй анимации
                })
            }
        } else {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            sender.tintColor = .black
        }
        
        isTurn.toggle()
    }
}
// MARK: Setup UI Elements
private extension ProductCell {
    
    func imageview() {
        
        contentView.addSubview(imageView)
        
        imageView.setConstraint(.top, from: contentView, 0)
        imageView.setConstraint(.left, from: contentView, 0)
        imageView.setConstraint(.right, from: contentView, 0)
        imageView.setConstraint(.height, from: contentView, 115)
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    func titlelabel() {
        
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 11).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive = true
        
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.numberOfLines = 0
    }
    
    func timelabel() {
        
        contentView.addSubview(timeLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 11).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -11).isActive = true
        
        timeLabel.font = .systemFont(ofSize: 10)
        timeLabel.textColor = .rgbAll(89)
    }
    
    func pricelabel() {
        
        contentView.addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 11).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -11).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    func heartbutton() {
        
        contentView.addSubview(heartButton)
        
        heartButton.setConstraint(.width, from: UIView(), 17)
        heartButton.setConstraint(.height, from: UIView(), 17)
        heartButton.setConstraint(.right, from: contentView, 13)
        heartButton.setConstraint(.bottom, from: contentView, 55)
        
        heartButton.tintColor = .black
        
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }
}
