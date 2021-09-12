//
//  AppDelegate.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 29/8/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var memes = [Meme]()
    
    let myMemeOne = Meme(topText: "MemeOneTop", bottomText: "MemeOneBottom", originalImage: UIImage(named: "Big")!, memedImage: UIImage(named: "Big")!)
    let myMemeTwo = Meme(topText: "MemeTwoTop", bottomText: "MemeTwoBottom", originalImage: UIImage(named: "Blofeld")!, memedImage: UIImage(named: "Blofeld")!)
    let myMemeThree = Meme(topText: "MemeThreeTop", bottomText: "MemeThreeBottom", originalImage: UIImage(named: "Drax")!, memedImage: UIImage(named: "Drax")!)
    let myMemeFour = Meme(topText: "MemeFourTop", bottomText: "MemeFourBottom", originalImage: UIImage(named: "EmilioLargo")!, memedImage: UIImage(named: "EmilioLargo")!)
    let myMemeFive = Meme(topText: "MemeFiveTop", bottomText: "MemeFiveBottom", originalImage: UIImage(named: "Goldfinger")!, memedImage: UIImage(named: "Goldfinger")!)
    let myMemeSix = Meme(topText: "MemeSixTop", bottomText: "MemeSixBottom", originalImage: UIImage(named: "Jaws")!, memedImage: UIImage(named: "Jaws")!)
    let myMemeSeven = Meme(topText: "MemeSevenTop", bottomText: "MemeSevenBottom", originalImage: UIImage(named: "Klebb")!, memedImage: UIImage(named: "Klebb")!)
    let myMemeEight = Meme(topText: "MemeEightTop", bottomText: "MemeEightBottom", originalImage: UIImage(named: "Silva")!, memedImage: UIImage(named: "Silva")!)
    let myMemeNine = Meme(topText: "MemeNineTop", bottomText: "MemeNineBottom", originalImage: UIImage(named: "OddJob")!, memedImage: UIImage(named: "OddJob")!)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        memes.append(myMemeOne)
        memes.append(myMemeTwo)
        memes.append(myMemeThree)
        memes.append(myMemeFour)
        memes.append(myMemeFive)
        memes.append(myMemeSix)
        memes.append(myMemeSeven)
        memes.append(myMemeEight)
        memes.append(myMemeNine)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

