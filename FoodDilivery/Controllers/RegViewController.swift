//
//  RegViewController.swift
//  FoodDilivery
//
//  Created by Преподаватель on 03.12.2021.
//

import UIKit

class RegViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneCode: UITextField!
    @IBOutlet weak var PhoneNum: UITextField!
    @IBOutlet weak var emailAddreas: UITextField!
    @IBOutlet weak var password: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        name.layer.cornerRadius = 10
        phoneCode.layer.cornerRadius = 10
        PhoneNum.layer.cornerRadius = 10
        emailAddreas.layer.cornerRadius = 10
        password.layer.cornerRadius = 10
        
        name.layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7333333333, alpha: 1)
        name.layer.borderWidth = 1
        phoneCode.layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7333333333, alpha: 1)
        phoneCode.layer.borderWidth = 1
        PhoneNum.layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7333333333, alpha: 1)
        PhoneNum.layer.borderWidth = 1
        emailAddreas.layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7333333333, alpha: 1)
        emailAddreas.layer.borderWidth = 1
        password.layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7333333333, alpha: 1)
        password.layer.borderWidth = 1

        
        name.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 15,
                                                  height: name.frame.height))
        phoneCode.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 15,
                                                  height: phoneCode.frame.height))
        PhoneNum.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 15,
                                                  height: PhoneNum.frame.height))
        emailAddreas.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 15,
                                                  height: emailAddreas.frame.height))
        password.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 15,
                                                  height: password.frame.height))
        
        let button = UIButton(frame: CGRect(x: -55,
                                            y: password.frame.midY - 15,
                                            width: 900,
                                            height: 30)
                              ,primaryAction: UIAction(handler:{ action in
            self.password.isSecureTextEntry.toggle()
            
        }))
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.7254371643, green: 0.7254599333, blue: 0.7340092063, alpha: 1)
        
        password.rightView = button
        
        name.leftViewMode = .always
        phoneCode.leftViewMode = .always
        PhoneNum.leftViewMode = .always
        password.leftViewMode = .always
        emailAddreas.leftViewMode = .always
        password.leftViewMode = .always
        password.rightViewMode = .always
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
    
    @IBAction func hide(_ sender: Any) {
        view.endEditing(true)
    }
    
    
}

