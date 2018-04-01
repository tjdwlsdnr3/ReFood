//
//  ResultViewController.swift
//  Food
//
//  Created by Jinuk Sung on 2018. 2. 26..
//  Copyright © 2018년 Studio Nuki. All rights reserved.
//

import UIKit
import SafariServices
import GoogleMobileAds


var foodMenu = FoodMenu()
var resultCollection = [String]()


class ResultViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var randomNumber : Int!
    var interstitial : GADInterstitial!

    @IBOutlet var listShow: UIButton!
    @IBOutlet var menuName: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet var wouldYou: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = createAndLoadInterstitial()
        addBannerViewToView(appDelegate.bannerView)
        appDelegate.bannerView.rootViewController = self
        appDelegate.bannerView.load(GADRequest())
        appDelegate.bannerView.delegate = self
        restartButton.setBackgroundImage(#imageLiteral(resourceName: "goBack"), for: .normal)
        makeResultCollectionAndPicture()
        print("resultCollection: \(resultCollection)")
    }
        

        // Do any additional setup after loading the view.
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeResultCollectionAndPicture() {
            for (key, value) in foodMenu.menuCollection {
            let result = appDelegate.myChoice
            if result[result.count - 1] == " " {
                resultCollection.append(key)
                //선택지 저장 배열의 마지막이 " "(아무거나)이면 메뉴컬렉션의 모든 키값을 배열에 저장. 검증 필요.
                } else if result == value {
                resultCollection.append(key)
                //선택지 배열과 메뉴들의 속성이 같으면 결과값 저장 메뉴에 저장
                }
        }
                randomNumber = Int(arc4random_uniform((UInt32(resultCollection.count))))
            if resultCollection.count != 0 {
                menuName.text = resultCollection[randomNumber]
                for (key, value) in foodMenu.menuPicture {
                    if menuName.text == key {
                        imgView.image = value
                        appDelegate.myLocation.updateValue(menuName.text!, forKey: "query")
                    }
                    }
            } else if resultCollection.count == 0 {
                wouldYou.isHidden = true
                menuName.text! = "메뉴 선정에 실패했습니다....ㅠ_ㅠ"
                imgView.image = #imageLiteral(resourceName: "nuclear_bomb")
                listShow.isHidden = true
        }
    }
    
    
    
    
    
    //재시작 버튼 - 처음 실행해서 위치정보 얻은 사람이 재시작 할때는 위치정보 받는 함수 실행 안되도록 만들기
    @IBAction func goRestart(_ sender: UIButton) {
        appDelegate.myChoice.removeAll() //선택지 저장하는 배열 초기화
        resultCollection.removeAll() //선택지에 따른 메뉴 저장하는 배열 초기화
        print("restartmyChoice: \(appDelegate.myChoice)")
        print("restartResultCollection: \(resultCollection)")
        appDelegate.runUpdateLocationFunction = false
        performSegue(withIdentifier: "goRestart", sender: self)
    }
    
    @IBAction func goList(_ sender: UIButton) {
        let searchWord = "\(appDelegate.myAddress) \(menuName.text!)"
        print(searchWord)
//        let searchAddress = "http://m.search.naver.com/search.naver?query=\(searchWord)"
        let searchAddress = "https://store.naver.com/restaurants/list?filterId=r07680109&menu=\(menuName.text!)&query=\(appDelegate.myAddress) 맛집"
        if let encodedURL = searchAddress.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let url = URL(string: encodedURL) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        } else {
            print("error")
        }
        }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID : "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
        return interstitial
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
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        print("interstitialDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }

    
    }

