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
    public convenience init(title:String,detail:String?) {
        self.init()
        self.setupTitle(title:title,detail:detail)
    }
    func setupTitle(title:String,detail:String?){
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.font = Styles.shared.fonts?.titleFont
        self.textStacks.addArrangedSubview(titleLabel)
        
        if let d = detail {
            let detailLabel = UILabel()
            detailLabel.text = d
            detailLabel.numberOfLines = 0
            detailLabel.font = Styles.shared.fonts?.detailFont
            self.textStacks.addArrangedSubview(detailLabel)
        }
    }
}
