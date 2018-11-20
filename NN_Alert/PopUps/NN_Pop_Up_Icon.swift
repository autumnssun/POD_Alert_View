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
    public init(title:String,
                            detail:String? = nil,
                            image:UIImage? = nil,
                            animate:Bool? = false) {
        super.init(title:title,detail:detail)
        self.setupIcon(image:image,animate:animate!)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}
