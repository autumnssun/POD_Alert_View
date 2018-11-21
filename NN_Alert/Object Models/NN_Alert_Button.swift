//
//  NN_Alert_Button.swift
//  NN_Alert
//
//  Created by Tran Khoa on 19/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import Material

public typealias NN_CompletionCallback = ()->()

public enum NN_Btn_Style{
    case destructive
    case emphasize
    case attention
    case normal
    case dismiss_normal
    case dismiss_highlight
}

public class NN_Button:RaisedButton{
    var action:Selector?
    var executioner:UIResponder?
    var host_alert:NN_Pop_Up_Modal?
    var button_style:NN_Btn_Style?
    public init(label:String,
                btnStyle:NN_Btn_Style?,
                action:Selector? = nil,
                executioner:UIResponder?=nil){
        super.init(title: label)
        self.contentEdgeInsets = UIEdgeInsets(top:10,
                                              left:15,
                                              bottom:10,
                                              right:15)
        self.applyStyle(btnStyle:btnStyle)
        self.layer.cornerRadius = 5
        self.titleLabel?.font = NN_Pop_Up_Manager.shared.style.fonts.buttonFont
        self.executioner = executioner
        self.action = action
        self.addTarget(self, action: #selector(executeAction), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func applyStyle(btnStyle:NN_Btn_Style?  = .dismiss_normal){
        self.button_style = btnStyle
        switch btnStyle! {
        case .normal :
            self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.setTitleColor(NN_Pop_Up_Manager.shared.style.colors.firstColor, for: .normal)
            self.shadowColor = .clear
            break;
        case .attention :
            self.backgroundColor = NN_Pop_Up_Manager.shared.style.colors.secondColor
            self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            break;
        case .destructive:
            self.backgroundColor = NN_Pop_Up_Manager.shared.style.colors.fourColor
            self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            break;
        case .emphasize:
            self.backgroundColor = NN_Pop_Up_Manager.shared.style.colors.firstColor
            self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            break
        case .dismiss_normal:
            self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.setTitleColor(NN_Pop_Up_Manager.shared.style.colors.firstColor, for: .normal)
            self.shadowColor = .clear
            break
        case .dismiss_highlight:
            self.backgroundColor = NN_Pop_Up_Manager.shared.style.colors.firstColor
            self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            break;
        }
    }
    
    
    
    public override func didMoveToSuperview() {
        if type(of: self.superview) == NN_Pop_Up_Modal.self{
            self.host_alert = self.superview as? NN_Pop_Up_Modal
        }
    }
    
    @objc func executeAction(){
        self.host_alert?.dismiss(animated: true, cancelCallback: true)
        self.executioner?.perform(action)
    }
    
}


