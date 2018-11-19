//
//  NN_PopUp_Binary.swift
//  NN_Alert
//
//  Created by Tran Khoa on 28/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
public class NN_Pop_Up_Binary_Options:NN_Pop_Up_Icon{
    public var buttonOne: NN_Button?{
        didSet{
            self.btnStacks.insertArrangedSubview(buttonOne!, at: 1)
        }
    }
    public var buttonTwo: NN_Button?{
        didSet{
            self.btnStacks.insertArrangedSubview(buttonTwo!,at: 1)
        }
    }
    
    convenience init(title:String,
                            detail:String? = nil,
                            image:UIImage? = nil,
                            animate:Bool? = false,
                            btnOne:NN_Button? = nil,btnTwo:NN_Button? = nil) {
        self.init()
        self.setupIcon(image:image,animate:animate!)
        self.setupTitle(title:title,detail:detail)
        self.buttonOne = btnOne
        self.buttonTwo = btnTwo
        self.setupBtns(btns:[btnOne,btnTwo])
    }
    
    func setupBtns(btns:[NN_Button?]){
        for btn in btns {
            if let bt = btn {
                self.btnStacks.addArrangedSubview(bt)
                if bt.button_style == .dismiss{
                    bt.addTarget(self, action: #selector(dismissBtnDidTapped), for: .touchUpInside)
                }
            }
        }
    }
}
