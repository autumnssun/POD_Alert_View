//
//  Tempura.swift
//  NN_Alert
//
//  Created by Tran Khoa on 26/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation

public class Tempura: NN_Pop_Up_Core{
    public convenience init(title:String) {
        self.init()
        self.setupTitle(title:title)
    }
    func setupTitle(title:String){
        let text = UITextField()
        text.placeholder = title
        self.dialogView.addSubview(text)
        text.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(36)
        }
    }
}
