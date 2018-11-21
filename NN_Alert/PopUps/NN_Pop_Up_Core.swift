//
//  NN_Alert.swift
//  NN_Alert
//
//  Created by Tran Khoa on 26/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import SnapKit
import Material
public class NN_Pop_Up_Core: UIView, NN_Pop_Up_Modal {
    
    

    public var backgroundView = UIView()
    public var dialogView = UIView()
    public var containerView = UIStackView()
    public var textStacks = UIStackView()
    public var btnStacks = UIStackView()
    public var callback: NN_CompletionCallback?
    public var cancelCallback: Bool = false

    public init() {
        super.init(frame: UIScreen.main.bounds)
        setUpStage(backgroundTappedAction:#selector(shouldDismiss))
      
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func shouldDismiss(){
        self.dismiss(animated: true)
    }
    
    
    public func dismiss(animated:Bool,cancelCallback:Bool? = nil){
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
        if let cancel = cancelCallback{
            self.cancelCallback = cancel
        }
        
        if let completed = callback, !self.cancelCallback{
            completed()
        }
    }
    
    
    public func show(animated:Bool,timeOutDuration:TimeInterval? = nil,completed:NN_CompletionCallback? = nil){
        self.backgroundView.alpha = 0
        self.callback = completed
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
    
    
}
