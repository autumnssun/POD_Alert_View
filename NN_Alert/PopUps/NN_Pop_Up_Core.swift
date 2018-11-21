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
    public init() {
        super.init(frame: UIScreen.main.bounds)
        setUpStage(backgroundTappedAction:#selector(didTappedOnBackgroundView))
        setUpKeyboardManager(view: self,
                             keyboardWillDisappearSelector: #selector(keyboardWillDisappearSelector),
                             keyboardWillAppearSelector: #selector(keyboardWillDisappearSelector))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
    @objc func dismissBtnDidTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func keyboardWillDisappearSelector(notification:Notification){
        self.adjustViewWithKeyboard(notification)
    }
    
    @objc func keyboardWillAppearSelector(notification:Notification){
        self.adjustViewWithKeyboard(notification)
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
