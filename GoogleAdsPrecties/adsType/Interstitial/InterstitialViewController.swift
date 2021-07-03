//
//  InterstitialViewController.swift
//  GoogleAdsPrecties
//
//  Created by Adsum MAC 2 on 03/07/21.
//

import GoogleMobileAds
import UIKit

class InterstitialViewController: UIViewController, GADFullScreenContentDelegate {
    
    private var interstitial: GADInterstitialAdBeta?

    override func viewDidLoad() {
        super.viewDidLoad()
        
      }
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("failed ad")
    }
    
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("addidpresent")
    }
    
    @IBAction func doSomething(_ sender: Any) {
        
        let request = GADRequest()
        GADInterstitialAdBeta.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910", request: request,
                          completionHandler: { [self] ad, error in
                            if let error = error {
                              print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                              return
                            }
                            interstitial = ad
                            interstitial?.fullScreenContentDelegate = self
                          }
        )
        
        
      if interstitial != nil {
        interstitial!.present(fromRootViewController: self)
      } else {
        print("Ad wasn't ready")
      }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
