//
//  ResultViewController.swift
//  Food
//
//  Created by Jinuk Sung on 2018. 2. 26..
//  Copyright © 2018년 Studio Nuki. All rights reserved.
//

import UIKit

var foodMenu = FoodMenu()
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let result = appDelegate.myChoice
var resultCollection = [String]()
var resultPictureCollection = [UIImage]()

class ResultViewController: UIViewController {

    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var menuName: UILabel!
    @IBOutlet var imgView: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeResultCollectionAndPicture()
        imgView.image = resultPictureCollection[0]
        menuName.text = resultCollection[0]
        print(resultCollection)
        pageControl.hidesForSinglePage = false
        pageControl.numberOfPages = resultCollection.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.green
        pageControl.pageIndicatorTintColor = UIColor.red
        }
    
        
        
        // Do any additional setup after loading the view.
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeResultCollectionAndPicture() {
        for (key, value) in foodMenu.menuCollection {
            if result == value {
                resultCollection.append(key)
                print(resultCollection)
                }
            for (key, value) in foodMenu.menuPicture {
                for i in 0 ..< resultCollection.count {
                    if resultCollection[i] == key {
                resultPictureCollection.append(value)
            }
            }
            }

}
}
    @IBAction func pageChanged(_ sender: UIPageControl) {
        menuName.text = resultCollection[pageControl.currentPage]
        imgView.image = resultPictureCollection[pageControl.currentPage]
    }
    
    
}
