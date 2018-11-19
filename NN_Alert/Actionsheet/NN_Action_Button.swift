//
//  NN_Action_Button.swift
//  NN_Alert
//
//  Created by Tran Khoa on 19/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import Material

public class NN_Action_Button:IconButton{
    
    public var localOption:ActionSheetRatioOption?
    public struct ActionSheetRatioOption {
        var optName:String
        var optID:String
        var active:Bool
        var description:String?
    }
    
    public init(title: String,
                icon:UIImage? = nil,
                pushLeft:Bool? = false,
                contentAtt:UISemanticContentAttribute? = .forceLeftToRight ) {
        super.init(title: title)
        self.pulseAnimation = .point
        self.titleLabel?.font = NN_Alert_Manager.shared.style.fonts.buttonFont
        self.titleColor = NN_Alert_Manager.shared.style.colors.buttonTextColorDark
        self.setImage(icon, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.semanticContentAttribute = contentAtt!
        switch contentAtt! {
        case .forceLeftToRight:
            self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                left: NN_Alert_Manager.shared.style.sizes.boxPadding + (imageView?.frame.width)!,
                                                bottom: 0,
                                                right: 0)
            break
        case .forceRightToLeft:
            self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                left: 0,
                                                bottom: 0,
                                                right: NN_Alert_Manager.shared.style.sizes.boxPadding+(imageView?.frame.width)!)
            break
        default:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,right: 0)
        }
        if pushLeft! {
            pushleft()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func pushleft(){
        self.titleLabel?.textAlignment  = .left
        self.contentHorizontalAlignment = .left
    }
    
    public func changeIcon(newIcon:UIImage){
        self.setImage(newIcon, for: .normal)
    }
}
