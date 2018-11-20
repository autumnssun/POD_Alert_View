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
import Material
class ViewController: UIViewController,NN_ActionSheet_Delegate{
    
    
    @IBOutlet weak var mainStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let action_1 = NN_Action_Sheet_Item(title:"action_1",id:"a_1",isCurrentSelected:true)
        let action_2 = NN_Action_Sheet_Item(title:"action_2",id:"a_2",isCurrentSelected:true)
        let action_3 = NN_Action_Sheet_Item(title:"action_3",id:"a_3")
        let action_4 = NN_Action_Sheet_Item(title:"action_4",id:"a_4")
        let action_5 = NN_Action_Sheet_Item(title:"action_5",id:"a_5")
        do {
            let items = try NN_List_Items([action_1,action_2,action_3,action_4,action_5],selectableCount:2)
            let btn = NN_ActionSheet_Trigger(title: "Trigger",actionList:items,host:self)
            view.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.height.equalTo(30)
                make.width.equalTo(200)
                make.centerY.equalToSuperview().offset(200)
                make.centerX.equalToSuperview()
            }
        }catch{
            print(error)
        }
    }
    @IBAction func hey(_ sender: Any) {
        let btn_1 = NN_Button(label: "dismiss", btnStyle: NN_Btn_Style.dismiss_highlight)
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
    
    @IBAction func showActionSheet(_ sender: Any) {
        
        
    }
    
    
    func actionCommited(actionSheet: NN_ActionSheet_Core, commitedAction: [NN_Action_Sheet_Item]) {
        for i in commitedAction{
            print(i.id)
        }
    }

}
 
