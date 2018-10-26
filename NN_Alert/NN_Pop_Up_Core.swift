//
//  NN_Alert.swift
//  NN_Alert
//
//  Created by Tran Khoa on 26/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import SnapKit
public class NN_Pop_Up_Core: UIView, NN_Modal {
    public var backgroundView = UIView()
    public var dialogView = UIView()
    
    public convenience init() {
        self.init(frame: UIScreen.main.bounds)
        setUpStage(backgroundTappedAction:#selector(didTappedOnBackgroundView))
        setUpKeyboardManager(view: self,
                             keyboardWillDisappearSelector: #selector(keyboardWillDisappearSelector),
                             keyboardWillAppearSelector: #selector(keyboardWillDisappearSelector))
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
    @objc func keyboardWillDisappearSelector(notification:Notification){
        self.adjustViewWithKeyboard(notification)
    }
    
    @objc func keyboardWillAppearSelector(notification:Notification){
        self.adjustViewWithKeyboard(notification)
    }
}
