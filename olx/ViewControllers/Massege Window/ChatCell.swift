//
//  ChatCell.swift
//  olx
//
//  Created by Asadbek Yoldoshev on 10/01/24.
//

import UIKit

final class ChatCell: UITableViewCell {
    
    let leftLabel = InsertLabel()
    let rightLabel = InsertLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        leftlabel()
        rightlabel()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: ChatData) {
    
        leftLabel.text = nil
        rightLabel.text = nil
        
        if data.direction == .left {
            if data.message.count == 1 {
                leftLabel.backgroundColor = .clear
                leftLabel.font = UIFont.boldSystemFont(ofSize: 50)
            } else {
                leftLabel.backgroundColor = .systemBlue
                leftLabel.font = UIFont.systemFont(ofSize: 16)
            }
            leftLabel.text = data.message
            leftLabel.textColor = .white
            leftLabel.textAlignment = .left
            
            let widthConstraint = NSLayoutConstraint(item: leftLabel, attribute: .width, relatedBy: .lessThanOrEqual, toItem: contentView, attribute: .width, multiplier: 0.7, constant: 0)
            widthConstraint.priority = .required - 1
            contentView.addConstraint(widthConstraint)
        } else {
            if data.message.count == 1 {
                rightLabel.backgroundColor = .clear
                rightLabel.font = UIFont.boldSystemFont(ofSize: 50)
            } else {
                rightLabel.backgroundColor = .systemGreen 
                rightLabel.font = UIFont.systemFont(ofSize: 16)
            }
            rightLabel.text = data.message
            rightLabel.textColor = .white
            rightLabel.textAlignment = .right
          
            let widthConstraint = NSLayoutConstraint(item: rightLabel, attribute: .width, relatedBy: .lessThanOrEqual, toItem: contentView, attribute: .width, multiplier: 0.7, constant: 0)
            widthConstraint.priority = .required - 1
            contentView.addConstraint(widthConstraint)
        }
    }
}

extension ChatCell {
    
    func leftlabel() {
        
        contentView.addSubview(leftLabel)
        
        leftLabel.layer.cornerRadius = 8
        leftLabel.clipsToBounds = true
        leftLabel.numberOfLines = 0
        
        leftLabel.setConstraint(.left, from: contentView, 5)
        leftLabel.setConstraint(.top, from: contentView, 5)
        leftLabel.setConstraint(.bottom, from: contentView, 5)
        leftLabel.textInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    func rightlabel() {
        
        contentView.addSubview(rightLabel)
        
        rightLabel.layer.cornerRadius = 8
        rightLabel.clipsToBounds = true
        rightLabel.numberOfLines = 0
        
        rightLabel.setConstraint(.right, from: contentView, 5)
        rightLabel.setConstraint(.top, from: contentView, 5)
        rightLabel.setConstraint(.bottom, from: contentView, 5)
        rightLabel.textInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
    }
}

extension UIView {
    enum Anchor{
        case left
        case right
        case width
        case height
        case top
        case bottom
    }
    
    func setConstraint(_ anchor: Anchor, from view: UIView, _ constraint: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch anchor {
        case .left:
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        case .right:
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        case .width:
            self.widthAnchor.constraint(equalToConstant: constraint).isActive = true
        case .height:
            self.heightAnchor.constraint(equalToConstant: constraint).isActive = true
        case .top:
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constraint).isActive = true
        case .bottom:
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constraint).isActive = true
        }
    }
}

class InsertLabel: UILabel {
    
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += textInsets.left + textInsets.right
        contentSize.height += textInsets.top + textInsets.bottom
        return contentSize
    }
}

