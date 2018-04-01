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
 
    let headers : [String : String] = ["Authorization" : "KakaoAK c5edc3592ed5689085e291339e73e9d5"]
    let locationURL = "https://dapi.kakao.com/v2/local/geo/coord2regioncode"
    var menuCollection : [String : [String]] = [
                                                "제육볶음" : ["나", "B", "b"],
                                                "김치찌개" : ["다", "C", "c"],
                                                "막창" : ["저녁", "술안주"],
                                                "곱창" : ["저녁", "술안주"],
                                                "닭발" : ["저녁", "술안주"],
                                                "순대국" : ["저녁", "술안주"],
                                                "연어" : ["저녁", "술안주"],
                                                "참치" : ["저녁", "술안주"],
                                                "삼겹살" : ["저녁", "술안주"],
                                                "소고기" : ["저녁", "술안주"],
                                                "오뎅탕" : ["저녁", "술안주"],
                                                "꼼장어" : ["저녁", "술안주"],
                                                "치킨" : ["저녁", "술안주"],
                                                "피자" : ["저녁", "술안주"],
                                                "해물파전" : ["저녁", "술안주"],
                                                "김치전" : ["저녁", "술안주"]
    ]
    
    var menuPicture : [String : UIImage] = [ "곱창" : #imageLiteral(resourceName: "gop"),
                                             "막창" : #imageLiteral(resourceName: "mak"),
                                             "김치찌개" : #imageLiteral(resourceName: "kim"),
                                             "제육볶음" : #imageLiteral(resourceName: "jaeyook"),
                                             "닭발" : #imageLiteral(resourceName: "dakbal"),
                                             "순대국" : #imageLiteral(resourceName: "soondae"),
                                             "삼겹살" : #imageLiteral(resourceName: "sam"),
                                             "참치" : #imageLiteral(resourceName: "tuna"),
                                             "소고기" : #imageLiteral(resourceName: "beef"),
                                             "오뎅탕" : #imageLiteral(resourceName: "oden"),
                                             "꼼장어" : #imageLiteral(resourceName: "jang_eo"),
                                             "치킨" : #imageLiteral(resourceName: "fried_chicken"),
                                             "피자" : #imageLiteral(resourceName: "pizza"),
                                             "해물파전" : #imageLiteral(resourceName: "haemoolpajeon"),
                                             "김치전" : #imageLiteral(resourceName: "gimchijun")
    ]
    
    
    
}
