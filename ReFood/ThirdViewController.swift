//
//  ThirdViewController.swift
//  Food
//
//  Created by Jinuk Sung on 2018. 2. 26..
//  Copyright © 2018년 Studio Nuki. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func thirdChoice(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.myChoice.append(sender.currentTitle!)
        print(appDelegate.myChoice)
        performSegue(withIdentifier: "goToResult", sender: self)
    }
   
}
