//
//  AppDelegate.swift
//  AbsenteeValet
//
//  Created by Kenneth Kantzer on 9/20/19.
//  Copyright © 2019 PKC Security. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()
    let center = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        }
        locationManager.requestAlwaysAuthorization()
        // Override point for customization after application launch.
        monitorRegionAtLocation(locationManager: locationManager)
        return true
    }
    
    func monitorRegionAtLocation(locationManager: CLLocationManager) {
        // Make sure the devices supports region monitoring.
        let center = CLLocationCoordinate2DMake(33.715290, -117.987293);
        let identifier = "yooooo";
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            // Register the region.
            let region = CLCircularRegion(center: center,
                                          radius: 500, identifier: identifier)
            region.notifyOnEntry = true
            region.notifyOnExit = false
            
            locationManager.startMonitoring(for: region)
            locationManager.delegate = self
            
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        // create CLLocation from the coordinates of CLVisit
        let clLocation = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)
        
        // Get location description
    }
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if let region = region as? CLCircularRegion {
            let identifier = region.identifier
            
            guard let url = URL(string: "https://axryf1np09.execute-api.us-east-1.amazonaws.com/dev/parking") else { return }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let dataResponse = data,
                    error == nil else {
                        print(error?.localizedDescription ?? "Response Error")
                        return }
                do{
                    //here dataResponse received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        dataResponse, options: [])
                    print(jsonResponse) //Response result
                    let jsonDict = jsonResponse as! [String: Any]
                    let carCountArray = jsonDict["carCount"] as! [Int]
                    let smallLot = carCountArray[0]
                    let smallLotVacancy = 4 - smallLot
                    let bigLot = carCountArray[1]
                    let bigLotVacancy = 6 - bigLot
                    //print(jsonDict)
                    // 1
                    let content = UNMutableNotificationContent()
                    content.title = "Parking Lot Update 🚙🚗"
                    content.body = "Parking lot statuses: Small lot vacancy: " + String(smallLotVacancy) + ", big Lot vacancy: " + String(bigLotVacancy)
                    content.sound = .default
                    
                    // 2
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                    let request = UNNotificationRequest(identifier: "asdfasdfasdf", content: content, trigger: trigger)
                    
                    // 3
                    self.center.add(request, withCompletionHandler: nil)
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
            task.resume()
            //triggerTaskAssociatedWithRegionIdentifier(regionID: identifier)
        }
    }
}
