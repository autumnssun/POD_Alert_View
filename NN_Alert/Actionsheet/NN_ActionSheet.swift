//
//  NN_ActionSheet.swift
//  NN_Alert
//
//  Created by Tran Khoa on 19/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import Material
public struct NN_Action_Sheet_Item {
    var sender:UIButton
    var action:Selector?
    var executioner:UIResponder?
    var name:String?
    init(sender: UIButton,name:String? = nil,
         action:Selector? = nil,
         executioner:UIResponder? = nil) {
        self.sender = sender
        self.action = action
        self.executioner = executioner
        self.name = name
    }
}

public protocol ActionSheeDelegate {
    func actionDidTap(actionSheet:NN_ActionSheet,actions:[NN_Action_Sheet_Item])
}

public class NN_ActionSheet:UIView, NN_Modal{
    lazy var actionTitle:UILabel! = UILabel()
    public var delegate:ActionSheeDelegate?
    public var actionItems:[NN_Action_Sheet_Item]!
    public var settings:NN_Styles = NN_Alert_Manager.shared.style
    public var backgroundView = UIView()
    public var dialogView = UIView()
    public var containerView = UIStackView()
    public var textStacks = UIStackView()
    public var btnStacks = UIStackView()

    convenience public init(title:String?=nil,
                     actionItems:[NN_Action_Sheet_Item],
                     delegate:ActionSheeDelegate?){
        self.init(frame: UIScreen.main.bounds)
        self.actionItems = actionItems
        self.delegate = delegate
        buildStage()
        buildTitle(title:title)
        buildActions()
    }
    
    
    func buildTitle(title:String?){
        self.actionTitle?.text = title
        dialogView.addSubview(actionTitle!)
        actionTitle?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(NN_Alert_Manager.shared.style.sizes.boxPadding)
            make.left.equalToSuperview().offset(NN_Alert_Manager.shared.style.sizes.boxPadding)
            make.width.equalToSuperview()
            make.height.equalTo(NN_Alert_Manager.shared.style.sizes.actionSheetHeight)
        })
    }
    func buildStage(){
        addSubview(dialogView)
        var _H:CGFloat = 200
        if let _actionItems = actionItems{
            _H = _H + CGFloat(_actionItems.count) * NN_Alert_Manager.shared.style.sizes.actionSheetHeight
        }
        
        dialogView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        dialogView.layer.cornerRadius = 5
        
        dialogView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(_H)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func buildActions(){
        if let _actionItems = actionItems{
            for (index,item) in _actionItems.enumerated(){
                
                item.sender.tag = index
                item.sender.addTarget(self, action: #selector(itemTapped), for: .touchUpInside)
                textStacks.addArrangedSubview(item.sender)
            }
        }
    }
    
    @objc func itemTapped(sender:UIButton){
        delegate?.actionDidTap(actionSheet: self,actions: actionItems)
        
        let _item = actionItems[sender.tag]
        if let executioner = _item.executioner, let action = _item.action{
            executioner.perform(action, with: _item.sender)
        }
        
    }
}
