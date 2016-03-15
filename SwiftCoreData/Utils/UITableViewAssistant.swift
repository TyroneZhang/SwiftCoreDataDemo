//
//  UITableViewAssistant.swift
//  CloudLibrarySwift
//
//  Created by Zhangyao on 12/1/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCellFromNibName(nibName: String) -> String {
        let nib: UINib = UINib(nibName: nibName, bundle: NSBundle.mainBundle())
        let cell: UITableViewCell = nib.instantiateWithOwner(nil, options: nil)[0] as! UITableViewCell
        self .registerNib(nib, forCellReuseIdentifier: cell.reuseIdentifier!)
        return cell.reuseIdentifier!
    }
}