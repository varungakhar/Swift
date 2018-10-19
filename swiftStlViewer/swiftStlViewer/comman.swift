//
//  comman.swift
//  swiftStlViewer
//
//  Created by user on 10/16/18.
//  Copyright © 2018 Rajat. All rights reserved.
//

import UIKit

class comman: NSObject {

    
    func userdefultSET(value:String,key:String) {
       
       UserDefaults.standard.setValue(value, forKey: key)
       UserDefaults.standard.synchronize()
    }
    
    func remove(key:String) {
        
     UserDefaults.standard.removeObject(forKey: key)
     UserDefaults.standard.synchronize()
        
    }
    
    func getVALUES(key:String) -> Any {
        
        let str = UserDefaults.standard.value(forKey: key)
        UserDefaults.standard.synchronize()
        
        return str
        
    }
    
}
