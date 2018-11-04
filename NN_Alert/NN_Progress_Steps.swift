//
//  NN_Progress_Steps.swift
//  NN_Alert
//
//  Created by Tran Khoa on 3/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
public class NN_Progress_Steps:NN_Pop_Up_Binary{
    public convenience init(title:String,
                            steps:[Step],
                            detail:String? = nil,
                            image:UIImage? = nil,
                            animate:Bool? = false,
                            netralBtnText:String? = nil,
                            executioner:UIResponder? = nil,
                            executeBtnText:String? = nil,
                            executeAction:Selector? = nil,
                            executeBtnStyle:BtnStyle? = .normal){
        self.init(title: title,
                  detail: detail,
                  image: image,
                  animate: animate,
                  netralBtnText: netralBtnText,
                  executioner: executioner,
                  executeBtnText: executeBtnText, executeAction: executeAction, executeBtnStyle: executeBtnStyle)
        setupStep(steps:steps)

    }
    func setupStep(steps:[Step]){
        for step in steps{
            self.textStacks.addArrangedSubview(step)
        }
    }
}
