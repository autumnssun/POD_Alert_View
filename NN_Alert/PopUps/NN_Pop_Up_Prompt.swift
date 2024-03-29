//
//  NN_Pop_UP_Prompt.swift
//  NN_Alert
//
//  Created by Tran Khoa on 29/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import Material
import SwiftValidator

public class NN_Pop_Up_Prompt:NN_Pop_Up_Binary_Options,UITextFieldDelegate{
    let promptTextField:ErrorTextField = ErrorTextField()
    var actionExecutioner:UIResponder?
    var actionSelector:Selector?
    var validator:Validator = Validator()
    public init(title:String,
                detail:String? = nil,
                image:UIImage? = nil,
                animate:Bool? = false,
                promptPlaceHolder:String? = nil,
                promptPrefill:String? = nil,
                dismisBtnLabel:String,
                actionBtnLabel:String,
                actionSelector:Selector? = nil,
                actionExecutioner:UIResponder? = nil,
                rules:[Rule]? = nil) {
        
        super.init(title: title, detail: detail, image: image, animate: animate)
        let btnOne:NN_Button? = NN_Button(label: dismisBtnLabel, btnStyle: NN_Btn_Style.normal, action: #selector(shouldDismiss), executioner: self)
        let btnTwo:NN_Button? = NN_Button(label: actionBtnLabel, btnStyle: NN_Btn_Style.emphasize, action: #selector(executePromptAction), executioner: self)
        self.buttonTwo = btnTwo
        self.buttonOne = btnOne
        self.actionExecutioner = actionExecutioner
        self.actionSelector = actionSelector
        self.setupPrompt(promptPlaceHolder: promptPlaceHolder, promptPrefill: promptPrefill)
        self.setupRules(rules)
        self.promptTextField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRules(_ r:[Rule]?){
        if let rules = r{
            validator.registerField(promptTextField, rules: rules)
        }
    }
    
    func setupPrompt(promptPlaceHolder:String?, promptPrefill:String?){
        promptTextField.text = promptPrefill
        promptTextField.placeholderVerticalOffset = 6
        promptTextField.placeholderActiveScale = 0.5
        promptTextField.placeholder = promptPlaceHolder
        self.textStacks.addArrangedSubview(promptTextField)
    }
    
    @objc func executePromptAction(){
        validator.validate { (issues) in
            if issues.count == 0{
                self.validated()
            }else{
                if let issue = issues.last,
                   let textField = issue.0 as? ErrorTextField{
                    textField.error = issue.1.errorMessage
                    textField.isErrorRevealed = true
                }
            }
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField){
        self.promptTextField.isErrorRevealed = false
        print("asdjh")
    }
    
    func validated(){
        self.dismiss(animated: true)
        self.actionExecutioner?.perform(actionSelector, with: self.promptTextField.text)
    }
}
