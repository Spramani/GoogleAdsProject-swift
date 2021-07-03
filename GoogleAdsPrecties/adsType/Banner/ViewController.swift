//
//  ViewController.swift
//  GoogleAdsPrecties
//
//  Created by Adsum MAC 2 on 02/07/21.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {
   
    @IBOutlet weak var bannerView: GADBannerView!
    
//    var bannerView: GADBannerView!

    let adSize = GADAdSizeFromCGSize(CGSize(width: 300, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Google Mobile Ads SDK version: \(GADMobileAds.sharedInstance().sdkVersion)")
        // In this case, we instantiate the banner with desired ad size.
//           bannerView = GADBannerView(adSize: kGADAdSizeBanner)

//           addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
         bannerView.rootViewController = self
         bannerView.load(GADRequest())
        
//        creatads()
    }
    
    func creatads()  {
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.delegate = self
        bannerView.rootViewController = self
     //   let request = GADRequest()
      
        bannerView.load(GADRequest())
       
    }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      bannerView.alpha = 0
      UIView.animate(withDuration: 1, animations: {
        bannerView.alpha = 1
      })
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
       bannerView.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(bannerView)
       
        NSLayoutConstraint.activate( [bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                      bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),bannerView.widthAnchor.constraint(equalTo: view.widthAnchor,constant: 50),bannerView.heightAnchor.constraint(equalToConstant: 100)])
      }
    
   
}

