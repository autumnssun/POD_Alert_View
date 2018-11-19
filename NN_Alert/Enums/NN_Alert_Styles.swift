//
//  NN_Alert_Styles.swift
//  NN_Alert
//
//  Created by Tran Khoa on 19/11/18.
//  Copyright © 2018 m3dicine. All rights reserved.
//

import Foundation


public enum NN_Alert_Type{
    case successfull
    case fail
    case info
    case working
    case caution
    case prompt
}

public struct NN_Styles{
    public var fonts: NN_Alerts_Fonts
    public var sizes: NN_Alerts_Sizes
    public var colors: NN_Alerts_Colors
    
    public init(colorSets:NN_Alerts_Colors? = NN_Alerts_Colors(),
                fontSets:NN_Alerts_Fonts? = NN_Alerts_Fonts(),
                sizeSets:NN_Alerts_Sizes? = NN_Alerts_Sizes()) {
        self.fonts = fontSets!
        self.colors = colorSets!
        self.sizes = sizeSets!
    }
    
    public struct NN_Alerts_Fonts{
        var titleFont:UIFont
        var detailFont:UIFont
        var buttonFont:UIFont
        public init(titleFont:UIFont? = UIFont(name: "Avenir-Heavy", size: UIFont.labelFontSize)!,
                    detailFont:UIFont? = UIFont(name: "Avenir-Light", size: UIFont.systemFontSize)!){
            self.titleFont = titleFont!
            self.detailFont = detailFont!
            self.buttonFont = titleFont!
        }
    }
    
    public struct NN_Alerts_Sizes{
        var paddings:CGFloat
        var boxPadding:CGFloat
        public init(padding:CGFloat? = 16, boxPadding:CGFloat? = 5){
            self.paddings = padding!
            self.boxPadding = boxPadding!
        }
    }
    
    public struct NN_Alerts_Colors{
        var buttonTextColorLight:UIColor
        var buttonTextColorDark:UIColor
        var firstColor:UIColor
        var secondColor:UIColor
        var thirdColor:UIColor
        var fourColor:UIColor
        public init(textLight:UIColor? = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                    textDark:UIColor? = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                    firstColor:UIColor? = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),
                    secondColor:UIColor? = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
                    thirdColor:UIColor? = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),
                    fourColor:UIColor? = #colorLiteral(red: 0.87843137254, green:0.02745098039, blue: 0.02745098039, alpha: 1)) {
            self.buttonTextColorLight = textLight!
            self.buttonTextColorDark = textDark!
            self.firstColor = firstColor!
            self.secondColor = secondColor!
            self.thirdColor = thirdColor!
            self.fourColor = fourColor!
        }
    }
}
