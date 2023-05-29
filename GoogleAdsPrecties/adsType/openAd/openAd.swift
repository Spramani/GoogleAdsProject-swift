import UIKit
import GoogleMobileAds

class openAd:UIViewController,GADFullScreenContentDelegate {
    
    let timeoutInterval: TimeInterval = 4 * 3_600
    var appOpenAd: GADAppOpenAd?
    var isLoadingAd = false
    var isShowingAd = false
    var loadTime: Date?
    
    var secondsRemaining: Int = 3
    /// The countdown timer.
    var countdownTimer: Timer?
    
    @IBOutlet weak var splashScreenLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        loadAd()
        showAdIfAvailable(viewController: self)

        // Do any additional setup after loading the view.
    }

  private func wasLoadTimeLessThanNHoursAgo(timeoutInterval: TimeInterval) -> Bool {
    // Check if ad was loaded more than n hours ago.
    if let loadTime = loadTime {
      return Date().timeIntervalSince(loadTime) < timeoutInterval
    }
    return false
  }

  private func isAdAvailable() -> Bool {
    // Check if ad exists and can be shown.
    return appOpenAd != nil && wasLoadTimeLessThanNHoursAgo(timeoutInterval: timeoutInterval)
  }

  private func appOpenAdManagerAdDidComplete() {
    // The app open ad is considered to be complete when it dismisses or fails to show,
    // call the delegate's appOpenAdManagerAdDidComplete method if the delegate is not nil.
 //   appOpenAdManagerDelegate?.appOpenAdManagerAdDidComplete(self)
  }

  func loadAd() {
    // Do not load ad if there is an unused ad or one is already loading.
    if isLoadingAd || isAdAvailable() {
      return
    }
    isLoadingAd = true
    print("Start loading app open ad.")
    GADAppOpenAd.load(
        withAdUnitID: "ca-app-pub-3940256099942544/5662855259",
      request: GADRequest(),
      orientation: UIInterfaceOrientation.portrait
    ) { ad, error in
      self.isLoadingAd = false
      if let error = error {
        self.appOpenAd = nil
        self.loadTime = nil
        print("App open ad failed to load with error: \(error.localizedDescription).")
        return
      }

      self.appOpenAd = ad
      self.appOpenAd?.fullScreenContentDelegate = self
      self.loadTime = Date()
      print("App open ad loaded successfully.")
    }
  }

  func showAdIfAvailable(viewController: UIViewController) {
    // If the app open ad is already showing, do not show the ad again.
    if isShowingAd {
      print("App open ad is already showing.")
        countdownTimer?.invalidate()
      return
    }
    // If the app open ad is not available yet but it is supposed to show,
    // it is considered to be complete in this example. Call the appOpenAdManagerAdDidComplete
    // method and load a new ad.
    if !isAdAvailable() {
      print("App open ad is not ready yet.")
      appOpenAdManagerAdDidComplete()
      loadAd()
      return
    }
    if let ad = appOpenAd {
      print("App open ad will be displayed.")
      isShowingAd = true
      ad.present(fromRootViewController: viewController)
    }
  }
    
    @objc func decrementCounter() {
        secondsRemaining -= 1
        if secondsRemaining > 0 {
              splashScreenLabel.text = "App is done loading in: \(secondsRemaining)"
        } else {
              splashScreenLabel.text = "Done."
            countdownTimer?.invalidate()
            showAdIfAvailable(viewController: self)
        }
    }
    
    func startTimer() {
         splashScreenLabel.text = "App is done loading in: \(secondsRemaining)"
        countdownTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(decrementCounter),
            userInfo: nil,
            repeats: true)
    }
}

extension openAd {
  func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    print("App open ad is will be presented.")
  }


}
//
//  openAd.swift
//  GoogleAdsPrecties
//
//  Created by Mayank Mangukiya on 29/05/23.
//

import Foundation
