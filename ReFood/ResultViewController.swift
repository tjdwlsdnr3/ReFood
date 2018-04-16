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
    var searchKeyMenu : String!
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
        let result = appDelegate.myChoice
        if result[1] == "식사" {
            for (key, value) in foodMenu.menuCollection {
            if result[result.count - 1] == " " {
                resultCollection.append(key.trimmingCharacters(in: CharacterSet.whitespaces))
                //선택지 저장 배열의 마지막이 " "(아무거나)이면 메뉴컬렉션의 모든 키값을 배열에 저장(식사).
                } else if result == value {
                resultCollection.append(key.trimmingCharacters(in: CharacterSet.whitespaces))
                //선택지 배열과 메뉴들의 속성이 같으면 결과값 저장 메뉴에 저장
                }
        }
        } else if result[1] == "술안주" {
            for (key, value) in foodMenu.sideDishCollection {
                if result[result.count - 1] == " " {
                    resultCollection.append(key.trimmingCharacters(in: CharacterSet.whitespaces))
                    //선택지 저장 배열의 마지막이 " "(아무거나)이면 메뉴컬렉션의 모든 키값을 배열에 저장(술안주).
                } else if result == value {
                    resultCollection.append(key.trimmingCharacters(in: CharacterSet.whitespaces))
                    //선택지 배열과 메뉴들의 속성이 같으면 결과값 저장 메뉴에 저장
                }
            }
        } else if result[1] == "간편식" {
            for (key, value) in foodMenu.CVCollection {
                if result[result.count - 1] == " " {
                    resultCollection.append(key.trimmingCharacters(in: CharacterSet.whitespaces))
                    //선택지 저장 배열의 마지막이 " "(아무거나)이면 메뉴컬렉션의 모든 키값을 배열에 저장(간편식).
                } else if result == value {
                    resultCollection.append(key.trimmingCharacters(in: CharacterSet.whitespaces))
                    //선택지 배열과 메뉴들의 속성이 같으면 결과값 저장 메뉴에 저장
                }
            }
        }
                randomNumber = Int(arc4random_uniform((UInt32(resultCollection.count))))
        var whetherThereIsAPictureOfMenu : [UIImage] = []
            if resultCollection.count != 0 {
                menuName.text! = resultCollection[randomNumber]
                searchKeyMenu = menuName.text!
                switch searchKeyMenu {
                case "떡튀순" :
                    searchKeyMenu = "분식"
                case "삼각김밥", "컵라면", "도시락", "핫도그", "샌드위치", "만두", "시리얼" :
                    searchKeyMenu = "편의점"
                default :
                    break
                }
                print("searchKeyMenu : \(searchKeyMenu)")
                appDelegate.myLocation.updateValue(menuName.text!, forKey: "query")
                for (key, value) in foodMenu.menuPicture {
                    if menuName.text! == key {
                        whetherThereIsAPictureOfMenu.append(value)
                        //메뉴명이 menuPicture 배열의 key와 일치한다면 whetherThereIsAPictureOfMenu 배열에 해당 key의 value를 집어넣는다.
                        //만약에 일치하는 key가 없다면 배열에 넣을 수 없겠지?
                    }
                    if whetherThereIsAPictureOfMenu.count == 0 {
                        imgView.image = #imageLiteral(resourceName: "noneCat")
                        //일치하는 key가 없어서 배열의 요소 갯수가 0이면 noneCat 사진을 넣고
                    } else {
                        imgView.image = whetherThereIsAPictureOfMenu[0]
                        //일치하는 key가 있어서 배열에 value값이 추가된 경우에는 해당 사진을 imageView의 image로 노출~
                    }
        }
            } else {
                //if resultCollection.count != 0의 else구문. 즉 결과값이 없을 경우의 분기처리.
    wouldYou.isHidden = true
    menuName.text! = "메뉴 선정에 실패했습니다....ㅠ_ㅠ"
    imgView.image = #imageLiteral(resourceName: "noneCat")
    listShow.isHidden = true
    }
    }
    
    
    //재시작 버튼 - 처음 실행해서 위치정보 얻은 사람이 재시작 할때는 위치정보 받는 함수 실행 안되도록 만들기
    @IBAction func goRestart(_ sender: UIButton) {
        appDelegate.myChoice.removeAll() //선택지 저장하는 배열 초기화
        resultCollection.removeAll() //선택지에 따른 메뉴 저장하는 배열 초기화
        print("restartmyChoice: \(appDelegate.myChoice)")
        print("restartResultCollection: \(resultCollection)")
        appDelegate.runUpdateLocationFunction = false //함수업데이트 값을 false로 처리.
        performSegue(withIdentifier: "goRestart", sender: self)
    }
    
    @IBAction func goList(_ sender: UIButton) {
        
        let searchAddress = "https://store.naver.com/restaurants/list?filterId=r07680109&menu=\(searchKeyMenu!)&query=\(appDelegate.myAddress) 맛집"
        print(searchAddress)
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

