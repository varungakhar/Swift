//
//  AppDelegate.swift
//  swiftStlViewer
//
//  Created by user on 23/07/18.
//  Copyright © 2018 Rajat. All rights reserved.
//

import UIKit
import SwiftyDropbox

var KAppDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
var arrNamesOfAllStlFileOnDropBox = NSMutableArray()
    var userdefult = UserDefaults()
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        DropboxClientsManager.setupWithAppKey("dii0ouv1ajxcrll")

        // 66773428929-qdfmfgeo04dj5d9v9ppd0abcn0n2dmbb.apps.googleusercontent.com
        // AIzaSyB3ue1eogCebhfthWp1N8GIao_VnciNc6E
        //
//        let appKey = "dii0ouv1ajxcrll"      // Set your own app key value here.
//        let appSecret = "ypr2u022yuacumt"   // Set your own app secret value here.
//
//        let dropboxSession = DBSession(appKey: appKey, appSecret: appSecret, root: kDBRootAppFolder)
//        DBSession.setSharedSession(dropboxSession)

        return true
    }
   
 
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if let authResult = DropboxClientsManager.handleRedirectURL(url) {
            switch authResult {
            case .success:
                print("Success! User is logged into Dropbox.")
                let client = DropboxClientsManager.authorizedClient
                print(client) as! Any
                let fileManager = FileManager.default
                let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
               // getDropboxImages()
                let destURL = directoryURL.appendingPathComponent("myTestFile")
                let destination: (URL, HTTPURLResponse) -> URL = { temporaryURL, response in
                    return destURL
                }
                client?.files.download(path: "/test/path/in/Dropbox/account", overwrite: true, destination: destination)
                    .response { response, error in
                        if let response = response {
                            print(response)
                        } else if let error = error {
                            print(error)
                        }
                    }
                    .progress { progressData in
                        print(progressData)
                }
                
                
                // Download to Data
                client?.files.download(path: "/test/path/in/Dropbox/account")
                    .response { response, error in
                        if let response = response {
                            let responseMetadata = response.0
                            print(responseMetadata)
                            let fileContents = response.1
                            print(fileContents)
                        } else if let error = error {
                            print(error)
                        }
                    }
                    .progress { progressData in
                        print(progressData)
                }
            case .cancel:
                print("Authorization flow was manually canceled by user!")
            case .error(_, let description):
                print("Error: \(description)")
            }
        }
        return true
    }
    
    func getDropboxImages(){
        
      //  self.filenames = []
        
        // Check if the user is logged in
        // If so, display photo view controller
        if let client = DropboxClientsManager.authorizedClient {
            //KAppDelegate.showActivityIndicator()
            // List contents of app folder
            
            _ = client.files.listFolder(path: "").response { response, error in
            //    KAppDelegate.hideActivityIndicator()
                if let result = response {
                    print("Folder contents:")
                    for entry in result.entries {
                        print(entry.name)
                        
                        // Check that file is a photo (by file extension)
                        if entry.name.hasSuffix(".stl") || entry.name.hasSuffix(".obj") {
                            // Add photo!
                            
                            self.arrNamesOfAllStlFileOnDropBox.add(entry.name)
                        }
                        if entry.name.hasSuffix(".mov") || entry.name.hasSuffix(".mp4") {
                            // Add photo!
                            
                           // self.videosStrArr.append(entry.name)
                        }
                    }
                    if self.arrNamesOfAllStlFileOnDropBox.count != 0 {
                        let vcMain = ViewController()
                        vcMain.arrForDataToPassOnTable = self.arrNamesOfAllStlFileOnDropBox
                    let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = testController
                   
                    }
                } else {
                    print("Error: \(error!)")
                }
            }
        }
    }
    func showActivityIndicator() {
       // SwiftSpinner.show("Loading", animated: true)
    }
    
    func hideActivityIndicator() {
      //  SwiftSpinner.hide()
    }
    
    
     func applicationWillTerminate(_ application: UIApplication)
     {
        print("terminate")
        comman().remove(key: "selection_nil")
        
    }
    
}
