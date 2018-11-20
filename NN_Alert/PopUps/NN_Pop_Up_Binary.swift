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
    
    public init(title:String,
                            detail:String? = nil,
                            image:UIImage? = nil,
                            animate:Bool? = false,
                            btnOne:NN_Button? = nil,btnTwo:NN_Button? = nil) {
        super.init(title: title, detail: detail, image: image, animate: animate)
        self.setupIcon(image:image,animate:animate!)
        self.buttonOne = btnOne
        self.buttonTwo = btnTwo
        self.setupBtns(btns:[btnOne,btnTwo])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBtns(btns:[NN_Button?]){
        for btn in btns {
            if let bt = btn {
                self.btnStacks.addArrangedSubview(bt)
                if bt.button_style == .dismiss_normal || bt.button_style == .dismiss_highlight{
                    bt.addTarget(self, action: #selector(dismissBtnDidTapped), for: .touchUpInside)
                }
            }
        }
    }
}
