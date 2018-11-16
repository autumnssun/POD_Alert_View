//
//  NN_PopUp_Binary.swift
//  NN_Alert
//
//  Created by Tran Khoa on 28/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
public class NN_Pop_Up_Binary:NN_Pop_Up_Icon{
    
    var actionBtnAction:Selector?
    var executioner:UIResponder?
    public convenience init(title:String,
                            detail:String? = nil,
                            image:UIImage? = nil,
                            animate:Bool? = false,
                            netralBtnText:String? = nil,
                            executioner:UIResponder? = nil,
                            executeBtnText:String? = nil,
                            executeAction:Selector? = nil,
                            executeBtnStyle:BtnStyle? = .normal) {
        self.init()
        self.setupIcon(image:image,animate:animate!)
        self.setupTitle(title:title,detail:detail)
        self.setupBtn(netralBtnText: netralBtnText)
        self.actionBtnAction = executeAction
        self.executioner = executioner
        self.setupActionbtn(executeBtnText:executeBtnText)
    }
    
    func setupActionbtn(executeBtnText:String?){
        if let text = executeBtnText{
            let btn:UIButton = UIButton()
            btnStacks.addArrangedSubview(btn)
            btn.setTitle(text, for: .normal)
            btn.contentEdgeInsets = UIEdgeInsets(top: 10,
                                                 left: 10,
                                                 bottom: 10,
                                                 right: 10)
            btn.addTarget(self, action: #selector(executeAction), for: .touchUpInside)
            btn.backgroundColor = self.settings.colors.firstColor
        }
    }
    
    @objc func executeAction(){
        self.dismiss(animated: true)
        self.executioner?.perform(actionBtnAction)
    }
}
