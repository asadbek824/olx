//
//  MessageViewController.swift
//  olx
//
//  Created by Asadbek on 21/12/23.
//

import UIKit

struct ChatData {
    enum Direction {
        case left
        case right
    }
    
    let direction: Direction
    let message: String
    let isRead: Bool
    let time: String
}

final class MessageViewController: UIViewController {

    //MARK: - UI Elemants
    private let tableView = UITableView()
    private let textFiled = UITextField()
    
    //MARK: - Data
    private var bottomConstraintToKeyboard: CGFloat = .zero
    private var chatData: [ChatData] = [
        ChatData(direction: .left, message: "salom", isRead: true, time: "15:10"),
        ChatData(direction: .right, message: "alik", isRead: true, time: "15:11"),
        ChatData(direction: .right, message: "kim bu tanimdim?", isRead: true, time: "15:11"),
        ChatData(direction: .left, message: "mani tanimasez kere", isRead: true, time: "15:12"),
        ChatData(direction: .left, message: "tanishsak bo'ladimi", isRead: true, time: "15:12"),
        ChatData(direction: .right, message: "yoq uzur bo'lmidi", isRead: true, time: "15:13"),
        ChatData(direction: .right, message: "yana bir marta yozsez chorniy qilaman🤬🤬🤬", isRead: true, time: "15:13"),
        ChatData(direction: .left, message: "mani toshkentdan uyim bor qosha qosha moshinalarim bor", isRead: true, time: "15:14"),
        ChatData(direction: .left, message: "man bilan gaplashsangiz sizzi baxtli qilaman", isRead: true, time: "15:14"),
        ChatData(direction: .right, message: "xop", isRead: true, time: "15:20"),
        ChatData(direction: .right, message: "😍", isRead: true, time: "15:20"),
        ChatData(direction: .left, message: "😘", isRead: true, time: "15:20")
    ]
    private var isShowd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedView)))
        
        tableview()
        tf()
        textFieldDelegate()
    }
    
    @objc private func tappedView() {
        view.endEditing(true)
    }
    
    @objc private func keyboarDidHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.textFiled.frame.origin.y += self.bottomConstraintToKeyboard
            self.tableView.frame.origin.y += self.bottomConstraintToKeyboard
            self.isShowd = false
        }
    }
    
    @objc private func keyboarDidShow(_ notification: Notification) {
        if isShowd == false,
           let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            
            let keyboardFrameInView = view.convert(keyboardFrame , from: nil)
            let bottomConstraintToKeyboard = keyboardFrameInView.height
            
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.textFiled.frame.origin.y -= bottomConstraintToKeyboard
                self.tableView.frame.origin.y -= bottomConstraintToKeyboard
                self.tableView.scrollsToTop = true
                self.bottomConstraintToKeyboard = bottomConstraintToKeyboard
                self.isShowd = true
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Setup TableView Delegate && DataSources

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ChatCell else { return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) }
        
        let data = chatData[indexPath.row]
        
        cell.selectionStyle = .none
        cell.configure(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - Setup TextField Delegate

extension MessageViewController: UITextFieldDelegate {
    
    func textFieldDelegate() {
        
        textFiled.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}


// MARK: - Create UI

extension MessageViewController {
    
    private func tableview() {
        
        view.addSubview(tableView)
        
        tableView.setConstraint(.top, from: view, .zero)
        tableView.setConstraint(.bottom, from: view, .zero)
        tableView.setConstraint(.left, from: view, .zero)
        tableView.setConstraint(.right, from: view, .zero)
        
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.estimatedRowHeight = 50
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func tf() {
        
        let tfLeftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        view.addSubview(textFiled)
        
        textFiled.layer.cornerRadius = 20
        textFiled.layer.borderWidth = 1
        textFiled.leftViewMode = .always
        textFiled.leftView = tfLeftPaddingView
        textFiled.placeholder = "Send Massage"
        textFiled.frame = CGRect(x: 16, y: view.frame.height - 130, width: view.frame.width - 32, height: 40)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboarDidShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboarDidHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}
