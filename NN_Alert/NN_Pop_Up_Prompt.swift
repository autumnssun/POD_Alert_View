//
//  NN_Pop_UP_Prompt.swift
//  NN_Alert
//
//  Created by Tran Khoa on 29/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import Material
public class NN_Pop_Up_Prompt:NN_Pop_Up_Binary_Options{
    let promptTextField:ErrorTextField = ErrorTextField()
    var actionExecutioner:UIResponder?
    var actionSelector:Selector?
    public convenience init(title:String,
                            detail:String? = nil,
                            image:UIImage? = nil,
                            animate:Bool? = false,
                            promptPlaceHolder:String? = nil,
                            promptPrefill:String? = nil,
                            dismisBtnLabel:String,
                            actionBtnLabel:String,
                            actionSelector:Selector? = nil,
                            actionExecutioner:UIResponder? = nil) {
        
        self.init(title: title, detail: detail, image: image, animate: animate)
        
        let btnOne:NN_Button? = NN_Button(label: dismisBtnLabel, btnStyle: NN_Btn_Style.normal, action: #selector(dismissBtnDidTapped), executioner: self)
        let btnTwo:NN_Button? = NN_Button(label: actionBtnLabel, btnStyle: NN_Btn_Style.emphasize, action: #selector(executePromptAction), executioner: self)
        self.buttonTwo = btnTwo
        self.buttonOne = btnOne
        self.actionExecutioner = actionExecutioner
        self.actionSelector = actionSelector
        self.setupPrompt(promptPlaceHolder: promptPlaceHolder, promptPrefill: promptPrefill)
    }
    
    func setupPrompt(promptPlaceHolder:String?, promptPrefill:String?){
        promptTextField.text = promptPrefill
        promptTextField.placeholderVerticalOffset = 6
        promptTextField.placeholderActiveScale = 0.5
        promptTextField.placeholder = promptPlaceHolder
        self.textStacks.addArrangedSubview(promptTextField)
    }
    
    @objc func executePromptAction(){
        self.dismiss(animated: true)
        self.actionExecutioner?.perform(actionSelector, with: self.promptTextField.text)
    }
}
