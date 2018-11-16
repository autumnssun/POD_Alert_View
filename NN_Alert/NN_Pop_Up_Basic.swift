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
    public convenience init(title:String,detail:String? = nil) {
        self.init()
        self.setupTitle(title:title,detail:detail)
    }
    func setupTitle(title:String,detail:String?){
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.font = self.settings.fonts.titleFont
        titleLabel.textColor = self.settings.colors.buttonTextColorDark
        self.textStacks.addArrangedSubview(titleLabel)
        if let d = detail {
            let detailLabel = UILabel()
            detailLabel.text = d
            detailLabel.numberOfLines = 0
            detailLabel.font = self.settings.fonts.detailFont
            detailLabel.textColor = self.settings.colors.buttonTextColorDark
            self.textStacks.addArrangedSubview(detailLabel)
        }
    }
}
