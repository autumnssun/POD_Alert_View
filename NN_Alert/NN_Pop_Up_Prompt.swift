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
                            executioner:UIResponder? = nil,
                            executeBtnText:String? = nil,
                            executeAction:Selector? = nil,
                            executeBtnStyle:BtnStyle? = .normal,
                            promptPlaceHolder:String? = nil,
                            promptPrefill:String? = nil) {
        self.init(title: title, detail: detail, image: image, animate: animate, netralBtnText: netralBtnText)
        self.setupPrompt(promptPlaceHolder: promptPlaceHolder, promptPrefill: promptPrefill)
        self.setupExecutionBtn(executioner: executioner, executeBtnText: executeBtnText, executeAction: executeAction, executeBtnStyle: executeBtnStyle)
    }
    
    func setupPrompt(promptPlaceHolder:String?, promptPrefill:String?){
        promptTextField.text = promptPrefill
        promptTextField.placeholderVerticalOffset = 6
        promptTextField.placeholderActiveScale = 0.5
        promptTextField.placeholder = promptPlaceHolder
        self.textStacks.addArrangedSubview(promptTextField)
    }
    
    func setupExecutionBtn(executioner:UIResponder? = nil,
                           executeBtnText:String? = nil,
                           executeAction:Selector? = nil,
                           executeBtnStyle:BtnStyle? = .normal){
        self.actionBtnAction = executeAction
        self.executioner = executioner
        self.setupPromptExecuteBtn(executeBtnText:executeBtnText)
    }
    
    
    func setupPromptExecuteBtn(executeBtnText:String?){
        if let text = executeBtnText{
            let btn:UIButton = UIButton()
            btnStacks.addArrangedSubview(btn)
            btn.setTitle(text, for: .normal)
            btn.contentEdgeInsets = UIEdgeInsets(top: 10,
                                                 left: 10,
                                                 bottom: 10,
                                                 right: 10)
            btn.addTarget(self, action: #selector(executePromptAction), for: .touchUpInside)
            btn.backgroundColor = self.settings.colors.firstColor
        }
    }

    
    @objc func executePromptAction(){
        self.dismiss(animated: true)
        self.executioner?.perform(actionBtnAction, with: self.promptTextField.text)
    }

}
