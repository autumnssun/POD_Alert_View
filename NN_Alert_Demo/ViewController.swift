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
    @IBAction func showAlert(_ sender: Any) {
        let alert = NN_Pop_Up_Icon(title: "Error",
                                   detail: "hello",
                                   image: #imageLiteral(resourceName: "loading"),
                                   animate: true,
                                   netralBtnText:"OK")
        alert.show(animated: true)
    }

    @IBAction func alert_1(_ sender: Any) {
        let alert = NN_Pop_Up_Prompt(title: "Prompt alert",
                                    detail: "this is a prompt alert",
                                    image: #imageLiteral(resourceName: "warning"),
                                    netralBtnText: "Cancel",
                                    executioner:self,
                                    executeBtnText: "Confirm",
                                    executeAction: #selector(runsomething),
                                    promptPlaceHolder:"placeholder")
        alert.show(animated: true)
    }
    
    @IBAction func alert_2(_ sender: Any) {
        let alert = NN_Pop_Up_Binary(title: "Binary alert",
                                    detail: "this is a binary alert",
                                    image: #imageLiteral(resourceName: "success"),
                                    animate:true,
                                    netralBtnText: "OK",
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
        showSteps(self)
    }
    @IBAction func showSteps(_ sender: Any) {
        
        let step1 = Step(stepName:"Step1")
        let step2 = Step(stepName:"Step2")
        let steps = [step1,step2]
        step1.changeStatus(status: .working, updatedLabel: "working on it")
        let alert = NN_Progress_Steps(title: "steps",
                                      steps:steps,
                                     animate:false,
                                     netralBtnText: "Cancel",executioner:self,
                                     executeBtnText: "Confirm",
                                     executeAction: #selector(runsomethingelse))
        alert.btnStacks.isHidden = true
        let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(fireTimer), userInfo: (steps:steps,alert:alert), repeats: true)
        
        alert.show(animated: true)
    }
    @objc func fireTimer(timer:Timer) {
        if let userInfo = timer.userInfo as? (steps:[Step],alert:NN_Progress_Steps){
            let steps = userInfo.steps
            print(steps[0].status)
            if steps[1].status == .working{
                steps[1].changeStatus(status: .success, updatedLabel: "done yay")
                timer.invalidate()
                userInfo.alert.btnStacks.isHidden = false
            }

            if steps[0].status == .working{
                steps[0].changeStatus(status: .success, updatedLabel: "done")
                steps[1].changeStatus(status: .working, updatedLabel: "working")
            }
        }
    }
}
