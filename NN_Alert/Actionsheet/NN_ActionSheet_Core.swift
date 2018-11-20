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

public class NN_List_Items{
    var listTitle:String?
    var items:[NN_Action_Sheet_Item]!
    var selectableCount:Int!

    public var currentSelectedIndexes:[Int]!
    var selectedItems:[NN_Action_Sheet_Item]{
        var returnObj:[NN_Action_Sheet_Item] = []
        if currentSelectedIndexes.count <= items.count && currentSelectedIndexes.count <= selectableCount{
            for i in currentSelectedIndexes{
                returnObj.append(items[i])
            }
        }
        return returnObj
    }
    
    public init( _ items:[NN_Action_Sheet_Item],
                 selectableCount:Int? = 1,
                 listTitle:String? = nil ) throws {
        
        guard selectableCount! <= items.count else {
            throw NN_ActionSheetError.runtimeError("number of selectableCount can not be larger than number of item")
        }
        self.items = items
        self.selectableCount = selectableCount
        self.listTitle = listTitle
        self.currentSelectedIndexes = {
            var returnobj:[Int] = []
            for (index,item) in items.enumerated(){
                if item.isSelected {
                    returnobj.append(index)
                }
            }
            return returnobj
        }()
        
        guard self.currentSelectedIndexes.count <= selectableCount! else {
            throw  NN_ActionSheetError.runtimeError("number of selected items can not be larger than selectableCount")
        }

        for item in self.items!{
            item.addTarget(self, action: #selector(itemSelected), for: .touchUpInside)
        }
    }
    
    @objc func itemSelected(_ sender:NN_Action_Sheet_Item){
        if sender.isSelected {
            if currentSelectedIndexes.count < selectableCount{
            }else{
                currentSelectedIndexes.removeFirst()
            }
            if let index = self.items.firstIndex(of: sender) {
                currentSelectedIndexes.append(index)
            }
        }else{
            if let index = self.items.firstIndex(of: sender) {
                if let k = self.currentSelectedIndexes.firstIndex(of: index){
                    self.currentSelectedIndexes.remove(at: k)
                }
            }
        }
        updateUI(currentSelectedIndexes!)
    }
    func updateUI(_ currentSelectedIndexes:[Int]){
        for (index,item) in items.enumerated(){
            if currentSelectedIndexes.firstIndex(of: index) == nil{
                item.isSelected = false
            }
        }
    }
    
}






public class NN_Action_Sheet_Item: IconButton {
    public var id:String?
    public init(title: String,
                id:String,
                isCurrentSelected:Bool? = false,
                selected_icon:UIImage? = UIImage.fromWrappedBundleImage(#imageLiteral(resourceName: "22X22CheckBoxChecked")) ,
                unselected_icon:UIImage? = UIImage.fromWrappedBundleImage(#imageLiteral(resourceName: "uncheck")) ,
                contentAtt:UISemanticContentAttribute? = UISemanticContentAttribute.forceLeftToRight) {
        super.init(title: title)
        self.pulseAnimation = .radialBeyondBounds
        self.titleColor = NN_Pop_Up_Manager.shared.style.colors.buttonTextColorGray
        self.titleLabel?.font = NN_Pop_Up_Manager.shared.style.fonts.buttonFont
        self.setImage(unselected_icon, for: .normal)
        self.setImage(selected_icon, for: .selected)
        self.imageView?.contentMode = .scaleAspectFit
        self.semanticContentAttribute = contentAtt!
        self.isSelected = isCurrentSelected!
        self.id = id
        switch contentAtt! {
        case .forceLeftToRight:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: NN_Pop_Up_Manager.shared.style.sizes.boxPadding*2 + (imageView?.frame.width)!, bottom: 0, right: 0)
            break
        case .forceRightToLeft:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: NN_Pop_Up_Manager.shared.style.sizes.boxPadding*2 + (imageView?.frame.width)!)
            break
        default:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,right: 0)
        }
        self.titleLabel?.textAlignment  = .left
        self.contentHorizontalAlignment = .left
        
        self.addTarget(self, action: #selector(changeStatus), for: UIControl.Event.touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func changeStatus(){
        self.isSelected = !self.isSelected
    }
}

public protocol NN_ActionSheet_Delegate {
    func actionCommited(actionSheet:NN_ActionSheet_Core,commitedAction:[NN_Action_Sheet_Item])
}

public class NN_ActionSheet_Core:UIView, NN_ActionSheet_Modal{
    
    public var delegate:NN_ActionSheet_Delegate?
    public var actionItems:NN_List_Items?
    
    public var sheetTitle:UILabel?
    public var backgroundView = UIView()
    public var actionSheet = UIView()
    public var actionStack = UIStackView()
    
    var autoCommit:Bool!
    
    convenience public init(title:String?=nil,
                            items:NN_List_Items? = nil,
                            delegate:NN_ActionSheet_Delegate? = nil,
                            autoCommit:Bool? = false){
        self.init(frame: UIScreen.main.bounds)
        self.actionItems = items
        self.delegate = delegate
        self.autoCommit = autoCommit
        injectTitle(title:title)
        injectActions(actionItems:actionItems?.items)
        setUpStage(backgroundTappedAction:#selector(didTappedOnBackgroundView))
    }
    
    
    func injectTitle(title:String?){
        if let title_unwraped = title{
            self.sheetTitle = UILabel()
            self.sheetTitle?.text = title_unwraped
            self.sheetTitle?.font = NN_Pop_Up_Manager.shared.style.fonts.titleFont
            actionSheet.addSubview(sheetTitle!)
            sheetTitle?.snp.makeConstraints({ (make) in
                make.top.equalToSuperview().offset(NN_Pop_Up_Manager.shared.style.sizes.paddings*2)
                make.left.equalToSuperview().offset(NN_Pop_Up_Manager.shared.style.sizes.paddings)
            })
        }
    }
    
    func injectActions(actionItems:[NN_Action_Sheet_Item]?){
        if let actions = actionItems{
            for action in actions {
                action.snp.makeConstraints { (make) in
                    make.height.equalTo(NN_Pop_Up_Manager.shared.style.sizes.actionSheetRowHeight)
                }
                actionStack.addArrangedSubview(action)
                action.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
            }
        }
    }
    
    @objc func didTappedOnBackgroundView(){
            dismiss(animated: true)
        if let actions = actionItems {
            delegate?.actionCommited(actionSheet: self, commitedAction: actions.selectedItems)
        }
    }
    
    @objc func actionTapped(_ sender:NN_Action_Sheet_Item){
        if let c=self.actionItems?.currentSelectedIndexes.count,
           let s=self.actionItems?.selectableCount,
           autoCommit && c==s {
            didTappedOnBackgroundView()
        }
    }
}
