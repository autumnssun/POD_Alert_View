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
    func show(animated:Bool,timeOutDuration:TimeInterval?,completed:NN_CompletionCallback?)
    func dismiss(animated:Bool,cancelCallback:Bool?)
    func setUpStage(backgroundTappedAction:Selector)

    var backgroundView:UIView {get}
    var dialogView:UIView {get set}
    var containerView:UIStackView {get set}
    var textStacks:UIStackView {get set}
    var btnStacks:UIStackView {get set}
    var cancelCallback:Bool{get set}
    var callback:NN_CompletionCallback?{get set}
}


public extension NN_Pop_Up_Modal where Self:UIView{
 

    
    
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
    
    
    
//
//    func setUpKeyboardManager(view:UIView,keyboardWillDisappearSelector:Selector,keyboardWillAppearSelector:Selector){
//        NotificationCenter.default.addObserver(view, selector: keyboardWillDisappearSelector, name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(view, selector: keyboardWillAppearSelector, name: UIResponder.keyboardWillShowNotification, object: nil)
//    }
//
//
//    func adjustViewWithKeyboard(_ notification:Notification){
//        print(notification)
//    }
}
