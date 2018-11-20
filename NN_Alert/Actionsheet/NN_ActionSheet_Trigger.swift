//
//  NN_ActionSheetTrigger.swift
//  NN_Alert
//
//  Created by Tran Khoa on 20/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import Material

public class NN_ActionSheet_Trigger:UIStackView,Pulseable{
    public var pulseAnimation: PulseAnimation = .radialBeyondBounds
    public var pulseColor: UIColor = NN_Pop_Up_Manager.shared.style.colors.firstColor
    public var pulseOpacity: CGFloat = 0.6
    
    public var label:UILabel?
    public var images:[UIImageView]?
    public var actionList:NN_List_Items?
    var host:UIViewController?
    public init(title:String,actionList:NN_List_Items,host:UIViewController) {
        super.init(frame: CGRect.zero)
        setUpTitle(title:title)
        self.actionList = actionList
        self.host = host
        
        self.alignment = .fill
        self.axis = .horizontal
        self.distribution = .fill
        
    }

    func setUpTitle(title:String){
        self.label = UILabel.init()
        self.label?.text = title
        self.insertSubview(label!, at: 0)
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
