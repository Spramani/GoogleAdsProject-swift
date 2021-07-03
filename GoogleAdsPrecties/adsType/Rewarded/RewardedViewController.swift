//
//  RewardedViewController.swift
//  GoogleAdsPrecties
//
//  Created by Adsum MAC 2 on 03/07/21.
//

import UIKit
import GoogleMobileAds

class RewardedViewController: UIViewController, GADRewardedAdDelegate {
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        let reward = rewardedAd.adMetadata
        // TODO: Reward the user!
        print(reward)
    }
    
    
    private var rewardedAd: GADRewardedAd?
    @IBOutlet weak var rewardLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadRewardedAd()
    }
    
    func loadRewardedAd() {
        let request = GADRequest()
        rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
        rewardedAd!.load(request){ error  in
            if let error = error {
                print("Rewarded ad failed to load with error: \(error.localizedDescription)")
                return
            }
            print("Rewarded ad loaded.")
        }
    }
    
    @IBAction func playVideoAd(_ sender: UIButton) {
        show()
    }
    
    func show() {
        if (rewardedAd != nil) {
            rewardedAd?.present(fromRootViewController: self, delegate: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
}

extension RewardedViewController : GADFullScreenContentDelegate{
    
    func ad(_ ad: GADFullScreenPresentingAd,didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }
    
    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
    }
    
    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
    }
    
}
