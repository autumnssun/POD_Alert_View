//
//  NN_Progress_Steps.swift
//  NN_Alert
//
//  Created by Tran Khoa on 3/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
public class NN_Pop_Up_Steps:NN_Pop_Up_Binary_Options{
    public init(title:String,
                steps:[Step],
                detail:String? = nil,
                image:UIImage? = nil,
                animate:Bool? = false,
                btnOne:NN_Button? = nil,
                btnTwo:NN_Button? = nil){

        super.init(title: title,
                   detail: detail,
                   image: image,
                   animate: animate,
                   btnOne:btnOne,
                   btnTwo:btnTwo)
        setupStep(steps:steps)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStep(steps:[Step]){
        for step in steps{
            self.textStacks.addArrangedSubview(step)
        }
    }
}
