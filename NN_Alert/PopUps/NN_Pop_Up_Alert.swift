//
//  NN_Pop_Up_Alert.swift
//  NN_Alert
//
//  Created by Tran Khoa on 19/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
public class NN_Pop_Up_Alert:NN_Pop_Up_Binary_Options{

    public init(type:NN_Alert_Type,
                title:String,
                detail:String? = nil,
                btnOne:NN_Button? = nil,
                btnTwo:NN_Button? = nil,
                completed:NN_CompletionCallback? = nil) {
        
        var statusImage = UIImage.fromWrappedBundleImage(#imageLiteral(resourceName: "loading"))
        var animated = false
        switch type {
        case .caution:
            statusImage = UIImage.fromWrappedBundleImage(#imageLiteral(resourceName: "warning"))
            break
        case .fail:
            statusImage = UIImage.fromWrappedBundleImage(#imageLiteral(resourceName: "error"))
            break
        case .info:
            statusImage = UIImage.fromWrappedBundleImage(#imageLiteral(resourceName: "info"))
            break
        case .successfull:
            statusImage = UIImage.fromWrappedBundleImage(#imageLiteral(resourceName: "success"))
            break
        case .prompt:
            statusImage = UIImage.fromWrappedBundleImage(#imageLiteral(resourceName: "prompt"))
            break
        case .working:
            statusImage = UIImage.fromWrappedBundleImage(#imageLiteral(resourceName: "loading"))
            animated = true
            break
        }
        super.init(title:title,
                   detail:detail,
                   image:statusImage,
                   animate:animated,
                   btnOne:btnOne,
                   btnTwo:btnTwo)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


