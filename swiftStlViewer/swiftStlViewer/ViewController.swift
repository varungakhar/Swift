//
//  ViewController.swift
//  swiftStlViewer
//
//  Created by user on 23/07/18.
//  Copyright © 2018 Rajat. All rights reserved.
//

import UIKit
import GLKit
import SceneKit
 import SwiftyDropbox
import Alamofire
 import MobileCoreServices
import ReplayKit

class ViewController: UIViewController, UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate, RPPreviewViewControllerDelegate {
   
    
    @IBOutlet var imgvwSample: UIImageView!
    @IBOutlet var constarintTopTableViewForSourceSelection: NSLayoutConstraint!
    @IBOutlet var constraintBottomViewForSourceSelection: NSLayoutConstraint!
    @IBOutlet var tblvwDataForSourceOfFile: UITableView!
    @IBOutlet var mySceneView: SCNView!
     @IBOutlet var vwTopTableView: UIView!
     @IBOutlet var labelIsRecordingOnOff: UILabel!
    var colorSelection:Int = 0
    var intTempValueForSource:Int = 0
    var arrForDataToPassOnTable = NSMutableArray()
    var strNameOfSTLfile = String()
    let recorder = RPScreenRecorder.shared()
    var userdefult = UserDefaults()
    private var isRecording = false
   // var newTempUrlFromiCloud:URL = URL()
    var newTempUrlFromiCloud = URL(string: "https://www.apple.com")
    @IBOutlet var vwSample: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelIsRecordingOnOff.isHidden = true
        self.constraintBottomViewForSourceSelection.constant = 1500
        self.constarintTopTableViewForSourceSelection.constant = 1500
      //  drawStlOnSceneKit()
        
            }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if intTempValueForSource != 0 {
        }

     

        
    }
   
    open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
        let screenshotImage:UIImage =  mySceneView.snapshot()
        
      
            UIImageWriteToSavedPhotosAlbum(screenshotImage, nil, nil, nil)
        DisplayAlert("Alert", "Screenshot saved in photos")
        return screenshotImage
    }
        
        
    
    @IBAction func btnActionCaptureImage(_ sender: Any) {
      takeScreenshot(true)
        
    }
    
    @IBAction func btnActionRecordVideo(_ sender: Any) {
    
        if !isRecording {
            
            
            startRecording()
        } else {
            
            self.labelIsRecordingOnOff.isHidden = true
            
            stopRecording()
        }
    }
    func DisplayAlert(_ AlertHeading:String, _ AlertDescription:String){
        let alert = UIAlertController(title: AlertHeading, message: AlertDescription , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    func startRecording() {
           self.labelIsRecordingOnOff.isHidden = false
        
        guard recorder.isAvailable else {
            print("Recording is not available at this time.")
            DisplayAlert("Alert", "Recording failed")
            return
        }
        
        
            recorder.isMicrophoneEnabled = true
       
        
        recorder.startRecording{ [unowned self] (error) in
            
            guard error == nil else {
                print("There was an error starting the recording.")
                return
            }
            
            print("Started Recording Successfully")
            self.DisplayAlert("Alert", "Recording Started")

            self.labelIsRecordingOnOff.isHidden = false
            self.isRecording = true
            
        }
        
    }
    func stopRecording() {
        
        recorder.stopRecording { [unowned self] (preview, error) in
            print("Stopped recording")
            
            guard preview != nil else {
                print("Preview controller is not available.")
                return
            }
            
            let alert = UIAlertController(title: "Recording Finished", message: "Would you like to edit or delete your recording?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action: UIAlertAction) in
                self.recorder.discardRecording(handler: { () -> Void in
                    print("Recording suffessfully deleted.")
                })
            })
            
            let editAction = UIAlertAction(title: "Edit", style: .default, handler: { (action: UIAlertAction) -> Void in
                preview?.previewControllerDelegate = self
                self.present(preview!, animated: true, completion: nil)
            })
            
            alert.addAction(editAction)
            alert.addAction(deleteAction)
            self.present(alert, animated: true, completion: nil)
            
            self.isRecording = false
            
          
            
        }
        
    }
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true)
    }
    
    

    
    @IBAction func btnActionChooseFile(_ sender: Any) {
//        if arrForDataToPassOnTable.count == 0 {
//        intTempValueForSource = 1
//        myButtonInControllerPressed()
//        }else {
//            self.constraintBottomViewForSourceSelection.constant = 62
//            self.constarintTopTableViewForSourceSelection.constant = 20
//        }
clickFunction()
        
      
    }
    
    @IBAction func btnActionAllColorSelection(_ sender: Any) {
        switch (sender as AnyObject).tag{
        case 1:
            colorSelection = 1
            break;
        case 2:
            colorSelection = 2
            break;
        case 3:
            colorSelection = 3
            break;
        case 4:
            colorSelection = 4
            break;
        case 5:
            colorSelection = 5
            break;
        case 6:
            colorSelection = 6
            break;
        default:
            break;
        }
        
     //   comman().userdefultSET(value: "1", key: "selection_nil")
        
        if let str =  comman().getVALUES(key: "selection_nil") as? String {
            print(str)

             //print("yes")
             drawStlOnSceneKit()
        }
        else
        {
            print("no")
        }

//
  
  
    }
    
//    func drawStlOnSceneKit(){
//
//        var ambientLightNode = SCNNode()
//        let diffuseColorNode = SCNNode()
//      //  let  scene = try! SCNScene(url: newTempUrlFromiCloud!, options: nil)
//        let stri:[String] = ["Rock_6.OBJ", ", E45Aircraft_obj.obj"]
//        let stringg:String = stri.joined(separator: " ")
//        let scene = try! SCNScene(named: "Rock_6.OBJ")
//
//      //  print(scene.attribute(forKey: "new"))
//        //        if let imageData = NSData(contentsOf: newTempUrlFromiCloud! as URL){
//        //           print(imageData)
//        //        }
//        var node1 = SCNNode()
//        var node2 = SCNNode()
//        var distance:SCNVector3
//        var distanceNew = SCNVector3()
//        if #available(iOS 11.0, *) {
//            let node1Pos = node1.presentation.worldPosition
//            let node2Pos = node2.presentation.worldPosition
//            let distance = SCNVector3(
//                node2Pos.x - node1Pos.x,
//                node2Pos.y - node1Pos.y,
//                node2Pos.z - node1Pos.z
//            )
//
//
//        } else {
//            // Fallback on earlier versions
//        }
//
//
//
//
//        // let val:CGFloat = CGFloat(scene.fogStartDistance.hashValue)
//
//
//        ambientLightNode.light = SCNLight()
//        ambientLightNode.light!.type = SCNLight.LightType.ambient
//        diffuseColorNode.light = SCNLight()
//        diffuseColorNode.light!.type = SCNLight.LightType.directional
//        diffuseColorNode.light!.type = SCNLight.LightType.omni
//
//        if colorSelection == 1{
//            ambientLightNode.light!.color = UIColor(red: 48/255, green: -5/255, blue: -139/255, alpha: 1.0)
//
//        }else if colorSelection == 2 {
//            ambientLightNode.light!.color = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1.0)
//        }else if colorSelection == 3 {
//            ambientLightNode.light!.color = UIColor(red: 18/255, green: -0/255, blue: -129/255, alpha: 1.0)
//        }else if colorSelection == 4 {
//            ambientLightNode.light!.color = UIColor(red: 0/255, green: 165/255, blue: 240/255, alpha: 1.0)
//        }else if colorSelection == 5{
//            ambientLightNode.light!.color = UIColor(red: 250/255, green: 35/255, blue: 10/255, alpha: 1.0)
//        }else if colorSelection == 6 {
//            ambientLightNode.light!.color = UIColor(red: -150/255, green: -150/255, blue: -150/255, alpha: 1.0)
//        }
//
//        scene?.rootNode.addChildNode(ambientLightNode)
//
//        mySceneView.autoenablesDefaultLighting = true
//        mySceneView.allowsCameraControl = true
//        mySceneView.scene = scene
//        mySceneView.backgroundColor = UIColor.red
//
//
//        getSizeOfModel(node2)
//
//
//    }
    

    
    
    
    func drawStlOnSceneKit(){

        var ambientLightNode = SCNNode()
        let diffuseColorNode = SCNNode()
        let  scene = try! SCNScene(url: newTempUrlFromiCloud!, options: nil)

     print(scene.attribute(forKey: "new"))
//        if let imageData = NSData(contentsOf: newTempUrlFromiCloud! as URL){
//           print(imageData)
//        }
        var node1 = SCNNode()
        var node2 = SCNNode()
        var distance:SCNVector3
        if #available(iOS 11.0, *) {
            let node1Pos = node1.presentation.worldPosition
            let node2Pos = node2.presentation.worldPosition
         //  let volume = SCNBoundingVolume(node1,node2)
             distance = SCNVector3(
                node2Pos.x - node1Pos.x,
                node2Pos.y - node1Pos.y,
                node2Pos.z - node1Pos.z
            )

           print(distance)
           // let volume = SCNBoundingVolume()
        } else {
            // Fallback on earlier versions
        }




       // let val:CGFloat = CGFloat(scene.fogStartDistance.hashValue)


        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        diffuseColorNode.light = SCNLight()
        diffuseColorNode.light!.type = SCNLight.LightType.directional
        diffuseColorNode.light!.type = SCNLight.LightType.omni

         if colorSelection == 1{
             ambientLightNode.light!.color = UIColor(red: 48/255, green: -5/255, blue: -139/255, alpha: 1.0)

        }else if colorSelection == 2 {
            ambientLightNode.light!.color = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1.0)
        }else if colorSelection == 3 {
            ambientLightNode.light!.color = UIColor(red: 18/255, green: -0/255, blue: -129/255, alpha: 1.0)
        }else if colorSelection == 4 {
            ambientLightNode.light!.color = UIColor(red: 0/255, green: 165/255, blue: 240/255, alpha: 1.0)
        }else if colorSelection == 5{
            ambientLightNode.light!.color = UIColor(red: 250/255, green: 35/255, blue: 10/255, alpha: 1.0)
        }else if colorSelection == 6 {
            ambientLightNode.light!.color = UIColor(red: -150/255, green: -150/255, blue: -150/255, alpha: 1.0)
        }
        scene.rootNode.addChildNode(ambientLightNode)




        mySceneView.autoenablesDefaultLighting = true
        mySceneView.allowsCameraControl = true
        mySceneView.scene = scene
        mySceneView.backgroundColor = UIColor.clear


    }
    
    func getSizeOfModel(_ node: SCNNode){
        
        //1. Get The Bouding Box Of The Node
        let (min, max) = node.boundingBox
        
        //2. Get It's Z Coordinate
        let zPosition = node.position.z
        
        //3. Get The Width & Height Of The Node
        let widthOfNode = max.x - min.x
        let heightOfNode = max.y - min.y
        
        //4. Get The Corners Of The Node
        let topLeftCorner = SCNVector3(min.x, max.y, zPosition)
        let bottomLeftCorner = SCNVector3(min.x, min.y, zPosition)
        let topRightCorner = SCNVector3(max.x, max.y, zPosition)
        let bottomRightCorner = SCNVector3(max.x, min.y, zPosition)
        
        print("""
            Width Of Node = \(widthOfNode)
            Height Of Node = \(heightOfNode)
            Bottom Left Coordinates = \(bottomLeftCorner)
            Top Left Coordinates = \(topLeftCorner)
            Bottom Right Coordinates = \(bottomRightCorner)
            Top Right Coordinates = \(topRightCorner)
            """)
        
        
    }
    func myButtonInControllerPressed() {
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: self,
                                                      openURL: { (url: URL) -> Void in
                                                        UIApplication.shared.openURL(url)
        })
       
    }
    func clickFunction(){
        
        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypeData)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }

    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
       // strNameOfSTLfile = String(myURL)
        strNameOfSTLfile = myURL.path
        newTempUrlFromiCloud = url
       comman().userdefultSET(value: "1", key: "selection_nil")
       
        drawStlOnSceneKit()

        
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
    
       comman().remove(key: "selection_nil")
        dismiss(animated: true, completion: nil)
        
        
    }
   
}
extension SCNVector3 {
    func length() -> Float {
        return sqrtf(x * x + y * y + z * z)
    }
}
func - (l: SCNVector3, r: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(l.x - r.x, l.y - r.y, l.z - r.z)
}

