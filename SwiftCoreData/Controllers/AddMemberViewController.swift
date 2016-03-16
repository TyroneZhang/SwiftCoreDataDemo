//
//  AddMemberViewController.swift
//  SwiftCoreData
//
//  Created by Zhangyao on 16/3/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    var family:Family?
    var member:Member?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidChangeFrameCallBack:"), name: UIKeyboardDidChangeFrameNotification, object: nil)
        if let member = self.member {
            self.nameTextField.text = member.name
            self.birthdayTextField.text = member.birthday
            self.sexTextField.text = member.sex
            self.title = "更新信息"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewMember(sender: AnyObject) {
        if self.family != nil { // add new member
            _ = Member.createEntity(self.nameTextField.text, birthday: self.birthdayTextField.text, sex: self.sexTextField.text, family: self.family)
        } else if self.member != nil { // update member information
            self.member!.name = self.nameTextField.text
            self.member!.birthday = self.birthdayTextField.text
            self.member!.sex = self.sexTextField.text
            self.member!.updateInformation()
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    internal func keyboardDidChangeFrameCallBack(notification: NSNotification) {
        let rect = notification.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue
        if CGRectGetMinY(rect!) < CGRectGetHeight(self.sexTextField.frame) + CGRectGetMinY(self.sexTextField.frame) + 64 {
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(rect!), 0)
        } else {
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        }
    }
    
    @IBAction func backgroundViewTapped(sender: AnyObject) {
        self.dismissKeyboard()
    }
    
    func dismissKeyboard() {
        let window = UIApplication.sharedApplication().keyWindow
        let firstResponder = window?.performSelector(Selector("firstResponder"))
        if firstResponder != nil {
            if let responder = firstResponder?.takeUnretainedValue() as? UITextField {
                responder.resignFirstResponder()
            } else if let responder = firstResponder?.takeUnretainedValue() as? UISearchBar {
                responder.resignFirstResponder()
            }
        }
    }
}
