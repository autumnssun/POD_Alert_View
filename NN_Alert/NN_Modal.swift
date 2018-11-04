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

public class Styles{
    static let shared = Styles()
    var fonts : NN_Alerts_Fonts?
    var sizes = NN_Alerts_Sizes()
    var color = NN_Alerts_Colors()
    
    init(fontSet:NN_Alerts_Fonts? = nil , sizeSet:NN_Alerts_Sizes? = nil) {
        self.fonts = NN_Alerts_Fonts(
            titleFont: UIFont(name: "Avenir-Heavy", size: UIFont.labelFontSize)!,
            detailFont: UIFont(name: "Avenir-Light", size: UIFont.systemFontSize)!)
    }
    
    public struct NN_Alerts_Fonts{
        var titleFont:UIFont?
        var detailFont:UIFont?
    }
    
    public struct NN_Alerts_Sizes{
        var paddings:CGFloat = 16
        var boxPadding:CGFloat = 5
    }
    
    public struct NN_Alerts_Colors{
        var buttonTextColorLight:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        var buttonTextColorDark:UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        var firstColor:UIColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        var secondColor:UIColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        var thirdColor:UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        var fourColor:UIColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
}

public protocol NN_Modal {
    func show(animated:Bool)
    func dismiss(animated:Bool)
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
    public func show(animated:Bool){
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
            make.centerY.equalToSuperview().offset(Styles.shared.sizes.paddings)
            make.height.greaterThanOrEqualTo(100)
            make.width.equalToSuperview().inset(Styles.shared.sizes.paddings)
            make.width.lessThanOrEqualTo(500)
        }
        
        let wrapperStack = UIStackView()
        
        dialogView.addSubview(wrapperStack)
        wrapperStack.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(Styles.shared.sizes.paddings)
            make.height.equalToSuperview().inset(Styles.shared.sizes.paddings)
        }
        wrapperStack.axis = .vertical
        wrapperStack.spacing = Styles.shared.sizes.boxPadding*2
        wrapperStack.addArrangedSubview(containerView)
        wrapperStack.addArrangedSubview(btnStacks)

        containerView.axis = .horizontal
        containerView.spacing = Styles.shared.sizes.boxPadding
        containerView.addArrangedSubview(textStacks)
        containerView.alignment = .top


        
        textStacks.axis = .vertical
        textStacks.spacing = Styles.shared.sizes.boxPadding
        textStacks.distribution = .equalSpacing
        textStacks.setContentHuggingPriority(UILayoutPriority.init(1), for:.vertical)
        
        btnStacks.axis = .horizontal
        btnStacks.alignment = .bottom
        btnStacks.spacing = Styles.shared.sizes.boxPadding
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
