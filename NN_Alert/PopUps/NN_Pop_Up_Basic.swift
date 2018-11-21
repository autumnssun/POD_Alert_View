//
//  NN_Pop_Up_Basic.swift
//  NN_Alert
//
//  Created by Tran Khoa on 27/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
import Material
public class NN_Pop_Up_Basic:NN_Pop_Up_Core{

    public init(title:String,detail:String? = nil) {
        super.init()
        self.setupTitle(title:title,detail:detail)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupTitle(title:String,detail:String?){
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.font = NN_Pop_Up_Manager.shared.style.fonts.titleFont
        titleLabel.textColor = NN_Pop_Up_Manager.shared.style.colors.buttonTextColorDark
        self.textStacks.addArrangedSubview(titleLabel)
        if let d = detail {
            let detailLabel = UILabel()
            detailLabel.text = d
            detailLabel.numberOfLines = 0
            detailLabel.font = NN_Pop_Up_Manager.shared.style.fonts.detailFont
            detailLabel.textColor = NN_Pop_Up_Manager.shared.style.colors.buttonTextColorDark
            self.textStacks.addArrangedSubview(detailLabel)
        }
    }

}
