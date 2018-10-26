//
//  NN_Modal.swift
//  NN_Alert
//
//  Created by Tran Khoa on 26/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import UIKit

public protocol NN_Modal {
    func show(animated:Bool)
    func dismiss(animated:Bool)
    var backgroundView:UIView {get}
    var dialogView:UIView {get set}
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
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: {
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
            make.width.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(32)
            make.height.greaterThanOrEqualTo(100)
            make.width.lessThanOrEqualTo(500)
        }
    }
    
    
    func adjustViewWithKeyboard(_ notification:Notification){
        print(notification)
    }

}
