//
//  NN_ActionSheet_Core.swift
//  NN_Alert
//
//  Created by Tran Khoa on 19/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation


public protocol NN_ActionSheet_Modal {
    
    func show(animated:Bool,timeOutDuration:TimeInterval?)
    func show_animated_timeOut()
    func dismiss(animated:Bool)
    func setUpStage(backgroundTappedAction:Selector)

    var sheetTitle:UILabel? {get}
    var backgroundView:UIView {get}
    var actionSheet:UIView {get}
    var actionStack:UIStackView {get}
}

public extension NN_ActionSheet_Modal where Self:UIView{
    public func show_animated_timeOut(){
        self.show(animated: true,timeOutDuration: 5)
    }
    public func show(animated:Bool,timeOutDuration:TimeInterval? = nil){
        self.backgroundView.alpha = 0
        self.actionSheet.center = CGPoint(x: self.center.x, y: self.frame.height + self.actionSheet.frame.height/2)
        
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
                            self.actionSheet.center  = self.center
            }, completion: { (completed) in
                
            })
        }else{
            self.backgroundView.alpha = 0.66
            self.actionSheet.center  = self.center
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
                self.actionSheet.center = CGPoint(x: self.center.x, y: self.frame.height + self.actionSheet.frame.height/2)
            }, completion: { (completed) in
                self.removeFromSuperview()
            })
        }else{
            self.removeFromSuperview()
        }
    }

    
    func setUpStage(backgroundTappedAction:Selector){
        addSubview(backgroundView)
        addSubview(actionSheet)
        
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: backgroundTappedAction))

        
        
        actionSheet.clipsToBounds = true
        actionSheet.layer.cornerRadius = 6
        actionSheet.backgroundColor = UIColor.white
        actionSheet.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview().multipliedBy(0.2)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        actionSheet.addSubview(actionStack)
        
        actionStack.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(NN_Pop_Up_Manager.shared.style.sizes.paddings)
            make.right.equalToSuperview().inset(NN_Pop_Up_Manager.shared.style.sizes.paddings)

            make.bottom.equalToSuperview().inset(NN_Pop_Up_Manager.shared.style.sizes.paddings*3)
            if let title = sheetTitle{
                make.top.equalTo(title.snp.bottom).offset(NN_Pop_Up_Manager.shared.style.sizes.paddings)
            }else{
                make.top.equalToSuperview().inset(NN_Pop_Up_Manager.shared.style.sizes.paddings)
            }
        }
        
        actionStack.axis = .vertical
        actionStack.spacing = NN_Pop_Up_Manager.shared.style.sizes.boxPadding
        actionStack.alignment = .fill
        actionStack.distribution = .equalSpacing
    }
}

enum NN_ActionSheetError: Error {
    case runtimeError(String)
}
