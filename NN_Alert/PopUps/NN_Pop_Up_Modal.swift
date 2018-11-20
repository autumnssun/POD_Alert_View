//
//  NN_Modal.swift
//  NN_Alert
//
//  Created by Tran Khoa on 26/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import UIKit
//import Material

public class NN_Pop_Up_Manager{
    public static let shared = NN_Pop_Up_Manager()
    public var style:NN_Styles!
    init(style:NN_Styles!=NN_Styles()) {
        self.style = style!
    }
}


public protocol NN_Pop_Up_Modal {
    func show(animated:Bool,timeOutDuration:TimeInterval?)
    func show_animated_timeOut()
    func dismiss(animated:Bool)
    func setUpStage(backgroundTappedAction:Selector)

    var backgroundView:UIView {get}
    var dialogView:UIView {get set}
    var containerView:UIStackView {get set}
    var textStacks:UIStackView {get set}
    var btnStacks:UIStackView {get set}
}


public extension NN_Pop_Up_Modal where Self:UIView{
 
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
            self.backgroundView.isUserInteractionEnabled = false
            Timer.scheduledTimer(withTimeInterval: waitDuration, repeats: false) { (timer) in
                self.dismiss(animated: false)
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
            make.centerY.equalToSuperview().offset(NN_Pop_Up_Manager.shared.style.sizes.paddings)
            make.height.greaterThanOrEqualTo(100)
            make.width.equalToSuperview().inset(NN_Pop_Up_Manager.shared.style.sizes.paddings)
            make.width.lessThanOrEqualTo(500)
        }
        
        let wrapperStack = UIStackView()
        
        dialogView.addSubview(wrapperStack)
        wrapperStack.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(NN_Pop_Up_Manager.shared.style.sizes.paddings)
            make.height.equalToSuperview().inset(NN_Pop_Up_Manager.shared.style.sizes.paddings)
        }
        wrapperStack.axis = .vertical
        wrapperStack.spacing = NN_Pop_Up_Manager.shared.style.sizes.boxPadding
        wrapperStack.addArrangedSubview(containerView)
        wrapperStack.addArrangedSubview(btnStacks)

        containerView.axis = .horizontal
        containerView.spacing = NN_Pop_Up_Manager.shared.style.sizes.boxPadding
        containerView.addArrangedSubview(textStacks)
        containerView.alignment = .top


        
        textStacks.axis = .vertical
        textStacks.spacing = NN_Pop_Up_Manager.shared.style.sizes.boxPadding
        textStacks.distribution = .equalSpacing
        textStacks.setContentHuggingPriority(UILayoutPriority.init(1), for:.vertical)
        
        btnStacks.axis = .horizontal
        btnStacks.alignment = .bottom
        btnStacks.spacing = NN_Pop_Up_Manager.shared.style.sizes.boxPadding
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