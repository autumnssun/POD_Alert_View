//
//  NN_Pop_Up.swift
//  NN_Alert
//
//  Created by Tran Khoa on 23/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import SwiftValidator
public class NN_Pop_Up_Email_Prompt:NN_Pop_Up_Prompt{
    public init(title:String,detail:String? = nil,
                image:UIImage? = nil,
                animate:Bool? = false,
                promptPlaceHolder:String? = nil,
                promptPrefill:String? = nil,
                dismisBtnLabel:String,
                actionBtnLabel:String,
                actionSelector:Selector? = nil,
                actionExecutioner:UIResponder? = nil,
                requiredErroMessager:String? = nil,
                emailFormatError:String? = nil){
        
        super.init(title: title, detail: detail, image: image, animate: animate, promptPlaceHolder: promptPlaceHolder, promptPrefill: promptPrefill, dismisBtnLabel: dismisBtnLabel, actionBtnLabel: actionBtnLabel, actionSelector: actionSelector, actionExecutioner: actionExecutioner,requiredErroMessager:requiredErroMessager)
    
        if let errorFormat = requiredErroMessager{
            validator.registerField(promptTextField, rules: [EmailRule(message: errorFormat)])
        }
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
