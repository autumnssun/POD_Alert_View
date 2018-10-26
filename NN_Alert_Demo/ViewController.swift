//
//  ViewController.swift
//  NN_Alert_Demo
//
//  Created by Tran Khoa on 26/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import UIKit
import SnapKit
import NN_Alert
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    @IBAction func showAlert(_ sender: Any) {
        let alert = Tempura(title:"hello world")
        alert.show(animated: true)
    }
    
}

