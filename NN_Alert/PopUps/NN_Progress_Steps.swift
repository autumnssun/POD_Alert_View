//
//  NN_Progress_Steps.swift
//  NN_Alert
//
//  Created by Tran Khoa on 3/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
public class NN_Progress_Steps:NN_Pop_Up_Binary_Options{
    public convenience init(title:String,
                            steps:[Step],
                            detail:String? = nil,
                            image:UIImage? = nil,
                            animate:Bool? = false,
                            btnOne:NN_Button? = nil,btnTwo:NN_Button? = nil){
        self.init(title: title,
                  detail: detail,
                  image: image,
                  animate: animate,
                  btnOne:btnOne,btnTwo:btnTwo)
        setupStep(steps:steps)

    }
    func setupStep(steps:[Step]){
        for step in steps{
            self.textStacks.addArrangedSubview(step)
        }
    }
}
