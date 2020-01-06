//
//  GlobalVariables.swift
//  FacilityBooking
//
//  Created by mallikarjun on 02/01/20.
//  Copyright © 2020 Mallikarjun H. All rights reserved.
//

import Foundation

class GlobalVariables {
    
   
    var selectedSlotsArrayForClub:[String] = []
    var selectedSlotsArrayForTennisCourt:[String] = []
    
    var selectedSlotsDataDictForClub:[String:Array] = [:] as! [String : Array<String>]
    
   // var selectedSlotsForClubAccordingData = [[String:[String]]]()
   // var selectedSlotsForTennisCourtAccordingData = [[String:[String]]]()
    
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
    
  
    
  
    
}
