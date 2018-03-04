//
//  ViewController.swift
//  Food
//
//  Created by Jinuk Sung on 2018. 2. 26..
//  Copyright © 2018년 Studio Nuki. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func firstchoice(_ sender: UIButton) {
   
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.myChoice.append(sender.currentTitle!)
        print(appDelegate.myChoice)
        
        
    performSegue(withIdentifier: "goToSecondChoice", sender: self)
    }

}

