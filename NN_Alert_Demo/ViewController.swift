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
        let alert = NN_Pop_Up_Icon(title: "Error", detail: "hello", image: #imageLiteral(resourceName: "loading"), animate: true,netralBtnText:"OK")
        alert.show(animated: true)
    }
    
    @IBAction func alert_1(_ sender: Any) {
        let alert = NN_PopUp_Binary(title: "Binary alert",
                                    detail: "this is a binary alert",
                                    image: #imageLiteral(resourceName: "warning"),
                                    netralBtnText: "Cancel",
                                    executioner:self,
                                    executeBtnText: "Confirm",
                                    executeAction: #selector(runsomething))
        alert.show(animated: true)
    }
    
    
    
    @IBAction func alert_2(_ sender: Any) {
        let alert = NN_PopUp_Binary(title: "Binary alert",
                                    detail: "this is a binary alert",
                                    image: #imageLiteral(resourceName: "loading"),
                                    animate:true,
                                    netralBtnText: "Cancel",
                                    executioner:self,
                                    executeBtnText: "Confirm",
                                    executeAction: #selector(runsomethingelse))
        alert.show(animated: true)
    }
    
    @objc func runsomething(){
        print("i am runing this")
        alert_2(self)
    }
    @objc func runsomethingelse(){
        print("i am runing this")
        alert_1(self)
    }
}

