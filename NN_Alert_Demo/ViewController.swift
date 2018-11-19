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
    }
    @IBAction func hey(_ sender: Any) {
        let btn_1 = NN_Button(label: "dismiss", btnStyle: NN_Btn_Style.dismiss)
        let btn_2 = NN_Button(label: "btn_2", btnStyle: NN_Btn_Style.destructive, action: nil, executioner: nil)
        let alert = NN_Pop_Up_Alert(type:.successfull,
                                    title: "Binary alert",
                                    detail: "This is a binary alert",
                                    btnOne:btn_1 ,
                                    btnTwo:btn_2 )
        alert.show(animated: true)
    }
    
    
    @IBAction func ho(_ sender: Any) {
        let prompt = NN_Pop_Up_Prompt(title: "Send Email", detail: "Please input Email", promptPlaceHolder: "Email", promptPrefill: "prompt prefill", dismisBtnLabel: "dismiss", actionBtnLabel: "Action", actionSelector: #selector(promptCallback), actionExecutioner: self)
        prompt.show(animated: true)
    }

    
    @IBAction func loadAlert(_ sender: Any) {
        let alert = NN_Pop_Up_Alert(type: .working, title: "Loading")
        alert.show(animated: true,timeOutDuration: 3)
    }
    
    
    @objc func promptCallback(text:String?){
        let alert = NN_Pop_Up_Alert(type: .working, title: "Loading")
        alert.show(animated: false,timeOutDuration: 3)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            if Bool.random(){
                let alert = NN_Pop_Up_Alert(type:.successfull, title: "Yay",detail:"Sent")
                alert.show(animated: false,timeOutDuration: 5)

            }else{
                let alert = NN_Pop_Up_Alert(type: .fail, title: "OH no", detail:"something wrong")
                alert.show(animated: false,timeOutDuration: 5)

            }
        }
    }
}
 
