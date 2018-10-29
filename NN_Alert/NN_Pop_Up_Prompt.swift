//
//  NN_Pop_UP_Prompt.swift
//  NN_Alert
//
//  Created by Tran Khoa on 29/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import Material
public class NN_Pop_Up_Prompt:NN_Pop_Up_Binary{
    let promptTextField:ErrorTextField = ErrorTextField()

    public convenience init(title:String,
                            detail:String? = nil,
                            image:UIImage? = nil,
                            animate:Bool? = false,
                            netralBtnText:String? = nil,
                            executioner:UIResponder,
                            executeBtnText:String? = nil,
                            executeAction:Selector? = nil,
                            executeBtnStyle:BtnStyle? = .normal,
                            promptPlaceHolder:String? = nil,
                            promptPrefill:String? = nil) {
        self.init()
        self.setupIcon(image:image,animate:animate!)
        self.setupTitle(title:title,detail:detail)
        self.setupBtn(netralBtnText: netralBtnText)
        self.actionBtnAction = executeAction
        self.executioner = executioner
        self.setupActionbtn(executeBtnText:executeBtnText)
        self.setupPrompt(promptPlaceHolder: promptPlaceHolder, promptPrefill: promptPrefill)
    }
    
    func setupPrompt(promptPlaceHolder:String?, promptPrefill:String?){
        promptTextField.text = promptPrefill
        promptTextField.placeholder = promptPlaceHolder
        textStacks.addArrangedSubview(promptTextField)
    }
}
