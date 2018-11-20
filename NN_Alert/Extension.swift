//
//  Extension.swift
//  NN_Alert
//
//  Created by Tran Khoa on 20/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation
public extension UIView{
    func rotateView(targetView: UIView, duration: Double = 0.5) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: .pi)
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }
}


extension UIImage {
    public static func fromWrappedBundleImage(_ wrappedImage: WrappedBundleImage) -> UIImage? {
        return wrappedImage.image
    }
}
public struct WrappedBundleImage: _ExpressibleByImageLiteral {
    public let image: UIImage?
    
    public init(imageLiteralResourceName name: String) {
        let bundle = Bundle(for: NN_Pop_Up_Manager.self)
        image = UIImage(named: name, in: bundle, compatibleWith: nil)
    }
}
