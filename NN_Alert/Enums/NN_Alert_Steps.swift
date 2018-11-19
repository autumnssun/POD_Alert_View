//
//  NN_Alert_Steps.swift
//  NN_Alert
//
//  Created by Tran Khoa on 19/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import UIKit

public enum StepStatus{
    case queing
    case working
    case success
    case fail
}
public class Step:UIStackView{
    public var status:StepStatus = .queing
    public var label:UILabel?
    public var image:UIImageView?
    
    public init(stepName:String) {
        super.init(frame: CGRect.zero)
        setUpVisual(stepName:stepName)
    }
    
    func setUpVisual(stepName:String){
        self.label = UILabel.init()
        self.image = UIImageView()
        
        self.addArrangedSubview(self.image!)
        self.addArrangedSubview(self.label!)
        
        self.label?.text = stepName
        
        let targetImage = #imageLiteral(resourceName: "loading")
        self.image?.image = targetImage
        self.image?.snp.makeConstraints({ (make) in
            make.width.equalTo(30)
            make.height.equalTo(30)
        })
        self.image?.setContentHuggingPriority(UILayoutPriority.init(2000), for: NSLayoutConstraint.Axis.horizontal)
        self.changeStatus(status: .queing)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pulseAnimation:CABasicAnimation{
        let pulseAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        return pulseAnimation
    }
    
    
    var rotate360Animation:CABasicAnimation{
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = 1
        rotateAnimation.autoreverses = false
        rotateAnimation.repeatCount = .greatestFiniteMagnitude
        return rotateAnimation
    }
    
    
    
    public func changeStatus(status:StepStatus,updatedLabel:String? = nil){
        self.status = status
        switch status {
        case .queing:
            self.image?.image = #imageLiteral(resourceName: "loading")
            self.label?.textColor = UIColor.colbb
            break
        case .working:
            self.image?.image = #imageLiteral(resourceName: "loading")
            self.label?.textColor = UIColor.col33
            if let newText = updatedLabel{
                label?.text = newText
            }
            self.image?.layer.add(rotate360Animation, forKey: "fullRevolution")
            self.label?.layer.add(pulseAnimation, forKey: "animateOpacity")
            break
        case .success:
            self.image?.image = #imageLiteral(resourceName: "success")
            self.label?.textColor = UIColor.col33
            if let newText = updatedLabel{
                label?.text = newText
            }
            self.label?.layer.removeAnimation(forKey: "animateOpacity")
            self.image?.layer.removeAnimation(forKey: "fullRevolution")
            break
        case .fail:
            self.image?.image = #imageLiteral(resourceName: "error")
            self.label?.textColor = UIColor.col33
            if let newText = updatedLabel{
                label?.text = newText
            }
            self.label?.layer.removeAnimation(forKey: "animateOpacity")
            self.image?.layer.removeAnimation(forKey: "fullRevolution")
            break
        }
    }
}

