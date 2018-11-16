//
//  NN_Modal.swift
//  NN_Alert
//
//  Created by Tran Khoa on 26/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import UIKit
import Material


public enum BtnStyle{
    case destructive
    case emphasize
    case attention
    case normal
}

public class NN_Alert_Manager{
    public static let shared = NN_Alert_Manager()
    public var style:NN_Styles!
    init(style:NN_Styles!=NN_Styles()) {
        self.style = style!
    }
}


public struct NN_Styles{
    public var fonts: NN_Alerts_Fonts
    public var sizes: NN_Alerts_Sizes
    public var colors: NN_Alerts_Colors
    
    public init(colorSets:NN_Alerts_Colors? = NN_Alerts_Colors(),
         fontSets:NN_Alerts_Fonts? = NN_Alerts_Fonts(),
         sizeSets:NN_Alerts_Sizes? = NN_Alerts_Sizes()) {
        self.fonts = fontSets!
        self.colors = colorSets!
        self.sizes = sizeSets!
    }
    
    public struct NN_Alerts_Fonts{
        var titleFont:UIFont
        var detailFont:UIFont
        var buttonFont:UIFont
        public init(titleFont:UIFont? = UIFont(name: "Avenir-Heavy", size: UIFont.labelFontSize)!,
            detailFont:UIFont? = UIFont(name: "Avenir-Light", size: UIFont.systemFontSize)!){
            self.titleFont = titleFont!
            self.detailFont = detailFont!
            self.buttonFont = titleFont!
        }
    }
    
    public struct NN_Alerts_Sizes{
        var paddings:CGFloat
        var boxPadding:CGFloat
        public init(padding:CGFloat? = 16, boxPadding:CGFloat? = 5){
            self.paddings = padding!
            self.boxPadding = boxPadding!
        }
    }
    
    public struct NN_Alerts_Colors{
        var buttonTextColorLight:UIColor
        var buttonTextColorDark:UIColor
        var firstColor:UIColor
        var secondColor:UIColor
        var thirdColor:UIColor
        var fourColor:UIColor
        public init(textLight:UIColor? = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                    textDark:UIColor? = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                    firstColor:UIColor? = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),
                    secondColor:UIColor? = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
                    thirdColor:UIColor? = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),
                    fourColor:UIColor? = #colorLiteral(red: 0.87843137254, green:0.02745098039, blue: 0.02745098039, alpha: 1)) {
            self.buttonTextColorLight = textLight!
            self.buttonTextColorDark = textDark!
            self.firstColor = firstColor!
            self.secondColor = secondColor!
            self.thirdColor = thirdColor!
            self.fourColor = thirdColor!
        }
    }
}

public protocol NN_Modal {
    func show(animated:Bool,timeOutDuration:TimeInterval?)
    func show_animated_timeOut()
    func dismiss(animated:Bool)
    var settings:NN_Styles{get set}
    var backgroundView:UIView {get}
    var dialogView:UIView {get set}
    var textStacks:UIStackView {get set}
    var btnStacks:UIStackView {get set}
    var containerView:UIStackView {get set}
}

public extension UIView{
    func rotateView(targetView: UIView, duration: Double = 0.5) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: .pi)
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }
    
}

public extension NN_Modal where Self:UIView{
 
    public func show_animated_timeOut(){
        self.show(animated: true,timeOutDuration: 5)
    }
    public func show(animated:Bool,timeOutDuration:TimeInterval? = nil){
        self.backgroundView.alpha = 0
        self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
        UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(self)
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0.66
            })
            UIView.animate(withDuration: 0.33,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 10,
                           options: UIView.AnimationOptions(rawValue: 0),
                           animations: {
                            self.dialogView.center  = self.center
            }, completion: { (completed) in
                
            })
        }else{
            self.backgroundView.alpha = 0.66
            self.dialogView.center  = self.center
        }
        
        if let waitDuration = timeOutDuration{
            Timer.scheduledTimer(withTimeInterval: waitDuration, repeats: false) { (timer) in
                self.dismiss(animated: true)
            }
        }
    }
    
    public func dismiss(animated:Bool){
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0
            }, completion: { (completed) in
                
            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: {
                self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
            }, completion: { (completed) in
                self.removeFromSuperview()
            })
        }else{
            self.removeFromSuperview()
        }
    }
    
    func setUpKeyboardManager(view:UIView,keyboardWillDisappearSelector:Selector,keyboardWillAppearSelector:Selector){
        NotificationCenter.default.addObserver(view, selector: keyboardWillDisappearSelector, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(view, selector: keyboardWillAppearSelector, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    func setUpStage(backgroundTappedAction:Selector){
        addSubview(backgroundView)
        addSubview(dialogView)
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: backgroundTappedAction))
        
        dialogView.clipsToBounds = true
        dialogView.layer.cornerRadius = 6
        dialogView.backgroundColor = UIColor.white
        
        dialogView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(self.settings.sizes.paddings)
            make.height.greaterThanOrEqualTo(100)
            make.width.equalToSuperview().inset(self.settings.sizes.paddings)
            make.width.lessThanOrEqualTo(500)
        }
        
        let wrapperStack = UIStackView()
        
        dialogView.addSubview(wrapperStack)
        wrapperStack.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(self.settings.sizes.paddings)
            make.height.equalToSuperview().inset(self.settings.sizes.paddings)
        }
        wrapperStack.axis = .vertical
        wrapperStack.spacing = self.settings.sizes.boxPadding*2
        wrapperStack.addArrangedSubview(containerView)
        wrapperStack.addArrangedSubview(btnStacks)

        containerView.axis = .horizontal
        containerView.spacing = self.settings.sizes.boxPadding
        containerView.addArrangedSubview(textStacks)
        containerView.alignment = .top


        
        textStacks.axis = .vertical
        textStacks.spacing = self.settings.sizes.boxPadding
        textStacks.distribution = .equalSpacing
        textStacks.setContentHuggingPriority(UILayoutPriority.init(1), for:.vertical)
        
        btnStacks.axis = .horizontal
        btnStacks.alignment = .bottom
        btnStacks.spacing = self.settings.sizes.boxPadding
        btnStacks.distribution = .fill
        
        let stretchingView = UIView()
        stretchingView.setContentHuggingPriority(UILayoutPriority.init(1000), for: .horizontal)
        stretchingView.backgroundColor = .clear
        stretchingView.translatesAutoresizingMaskIntoConstraints = false
        btnStacks.addArrangedSubview(stretchingView)
        
    }
    
    func adjustViewWithKeyboard(_ notification:Notification){
        print(notification)
    }
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

public enum StepStatus{
    case queing
    case working
    case success
    case fail
}
