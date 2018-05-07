//
//  SecondViewController.swift
//  Food
//
//  Created by Jinuk Sung on 2018. 2. 26..
//  Copyright © 2018년 Studio Nuki. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Alamofire
import SwiftyJSON


class SecondViewController: UIViewController, GADBannerViewDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    let foodMenu = FoodMenu()
    @IBOutlet var drinkSideDish: UIButton!
    @IBOutlet var goBackToFirst: UIButton!
    @IBOutlet var diningButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        appDelegate.bannerView.rootViewController = self
        appDelegate.bannerView.load(GADRequest())
        appDelegate.bannerView.delegate = self
        goBackToFirst.setBackgroundImage(#imageLiteral(resourceName: "goBack"), for: .normal)
        if appDelegate.myChoice[0] == "저녁" {
            drinkSideDish.isHidden = false
        } else {
            drinkSideDish.isHidden = true
        }
        if appDelegate.runUpdateLocationFunction == true {
        getLocationData(url: foodMenu.locationURL, parameters: appDelegate.myLocation)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    addBannerViewToView(appDelegate.bannerView)
    
    }
    
    
    @IBAction func secondChoice(_ sender: UIButton) {
        
        print(sender.currentTitle!)
        appDelegate.myChoice.append(sender.currentTitle!)
        print(appDelegate.myChoice)
        performSegue(withIdentifier: "goToThirdChoice", sender: self)
    }
    
    @IBAction func goBackToFirstChoice(_ sender: UIButton) {
        appDelegate.myChoice.remove(at: 0)
//        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goSideDish(_ sender: UIButton) {
        print(sender.currentTitle!)
        appDelegate.myChoice.append(sender.currentTitle!)
        print(appDelegate.myChoice)
        performSegue(withIdentifier: "chooseSideDish", sender: self)
        
    }
    
    
    
    func getLocationData(url : String, parameters : [String : Any]) {
        Alamofire.request(url, method : .get, parameters : parameters, headers : foodMenu.headers).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got the location data")
                let locationJSON : JSON = JSON(response.result.value!)
                print("\(locationJSON)")
                let locationSI = locationJSON["documents"][0]["region_1depth_name"].stringValue
                let locationGU = locationJSON["documents"][0]["region_2depth_name"].stringValue
                let locationDONG = locationJSON["documents"][0]["region_3depth_name"].stringValue
                self.appDelegate.myAddress = "\(locationSI) \(locationGU) \(locationDONG)"
                print("myAddress = \(self.appDelegate.myAddress)")
            } else {
                print("Error: \(String(describing: response.result.error))")
            }
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        if #available(iOS 11.0, *) {
            // In iOS 11, we need to constrain the view to the safe area.
            positionBannerViewFullWidthAtBottomOfSafeArea(bannerView)
        }
        else {
            // In lower iOS versions, safe area is not available so we use
            // bottom layout guide and view edges.
            positionBannerViewFullWidthAtBottomOfView(bannerView)
        }
    }
    
    // MARK: - view positioning
    @available (iOS 11, *)
    func positionBannerViewFullWidthAtBottomOfSafeArea(_ bannerView: UIView) {
        // Position the banner. Stick it to the bottom of the Safe Area.
        // Make it constrained to the edges of the safe area.
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            guide.leftAnchor.constraint(equalTo: bannerView.leftAnchor),
            guide.rightAnchor.constraint(equalTo: bannerView.rightAnchor),
            guide.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)
            ])
    }
    
    func positionBannerViewFullWidthAtBottomOfView(_ bannerView: UIView) {
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .leading,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .trailing,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: view.safeAreaLayoutGuide.bottomAnchor,
                                              attribute: .top,
                                              multiplier: 1,
                                              constant: 0))
    }

    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
