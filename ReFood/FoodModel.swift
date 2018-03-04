//
//  FoodModel.swift
//  Food
//
//  Created by Jinuk Sung on 2018. 2. 26..
//  Copyright © 2018년 Studio Nuki. All rights reserved.
//

import Foundation
import UIKit
class FoodMenu {
 
    var menuCollection : [String : [String]] = ["곱창" : ["가", "A", "a"],
                                                "제육볶음" : ["나", "B", "b"],
                                                "김치찌개" : ["다", "C", "c"],
                                                "막창" : ["가", "A", "a"]]
    var menuPicture : [String : UIImage] = [ "곱창" : #imageLiteral(resourceName: "gop"),
                                             "막창" : #imageLiteral(resourceName: "mak"),
                                             "김치찌개" : #imageLiteral(resourceName: "kim")]
    
}
