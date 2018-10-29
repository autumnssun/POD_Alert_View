//
//  NN_Pop_Up_Icon.swift
//  NN_Alert
//
//  Created by Tran Khoa on 28/10/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation

public class NN_Pop_Up_Icon:NN_Pop_Up_Basic{
    var imageView = UIImageView()
    public convenience init(title:String,
                            detail:String?,
                            image:UIImage? = nil,
                            animate:Bool? = false,
                            netralBtnText:String? = nil) {
        self.init()
        self.setupIcon(image:image,animate:animate!)
        self.setupTitle(title:title,detail:detail)
        self.setupBtn(netralBtnText: netralBtnText)
    }
    
    func setupBtn(netralBtnText:String?){
        if let btnLabel = netralBtnText {
            let btn:UIButton = UIButton()
            btnStacks.addArrangedSubview(btn)
            btn.setTitle(btnLabel, for: .normal)
            btn.setTitleColor(Styles.shared.color.firstColor, for: .normal)
            btn.contentEdgeInsets = UIEdgeInsets(top: 10,
                                                 left: 10,
                                                 bottom: 10,
                                                 right: 10)
            btn.addTarget(self, action: #selector(OKBtnDidTapped), for: .touchUpInside)
        }
    }
    
    func setupIcon(image:UIImage?, animate:Bool){
        if let img = image {
            containerView.insertArrangedSubview(imageView,at: 0)
            imageView.image = img
            imageView.snp.makeConstraints { (make) in
                make.width.equalTo(img.width)
                make.height.equalTo(img.height)
            }
            imageView.contentMode = .center
            if animate{
                self.rotateView(targetView:  imageView)
            }
        }
    }
    
    @objc func OKBtnDidTapped(){
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}
