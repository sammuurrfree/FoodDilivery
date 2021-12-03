//
//  AuthViewController.swift
//  FoodDilivery
//
//  Created by Преподаватель on 03.12.2021.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFIeld2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        textField.layer.cornerRadius = 10
        textFIeld2.layer.cornerRadius = 10
        
        textField.layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7333333333, alpha: 1)
        textField.layer.borderWidth = 1
        textFIeld2.layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7333333333, alpha: 1)
        textFIeld2.layer.borderWidth = 1
        
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 15,
                                                  height: textField.frame.height))
        textFIeld2.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 15,
                                                  height: textFIeld2.frame.height))
        
        let button = UIButton(frame: CGRect(x: -55,
                                            y: textFIeld2.frame.midY - 15,
                                            width: 900,
                                            height: 30)
                              ,primaryAction: UIAction(handler:{ action in
            self.textFIeld2.isSecureTextEntry.toggle()
            
        }))
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.7254371643, green: 0.7254599333, blue: 0.7340092063, alpha: 1)
        
        textFIeld2.rightView = button
        
        textField.leftViewMode = .always
        textFIeld2.leftViewMode = .always
        textFIeld2.rightViewMode = .always
    }
    

    @IBAction func hide(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}
