//
//  NN_Pop_Up_Alert.swift
//  NN_Alert
//
//  Created by Tran Khoa on 19/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
public class NN_Pop_Up_Alert:NN_Pop_Up_Binary_Options{

    public convenience init(type:NN_Alert_Type,title:String, detail:String? = nil,btnOne:NN_Button? = nil,btnTwo:NN_Button? = nil) {
        var statusImage = #imageLiteral(resourceName: "aida")
        var animated = false
        switch type {
        case .caution:
            statusImage = #imageLiteral(resourceName: "warning")
            break
        case .fail:
            statusImage = #imageLiteral(resourceName: "error")
            break
        case .info:
            statusImage = #imageLiteral(resourceName: "info")
            break
        case .successfull:
            statusImage = #imageLiteral(resourceName: "success")
            break
        case .prompt:
            statusImage = #imageLiteral(resourceName: "prompt")
            break
        case .working:
            statusImage = #imageLiteral(resourceName: "loading")
            animated = true
            break
        }
        self.init(title:title,detail:detail,image:statusImage,animate:animated,btnOne:btnOne,btnTwo:btnTwo)
    }
}
