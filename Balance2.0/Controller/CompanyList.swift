//
//  CompanyList.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-12.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit


class CompanyList {
    var allCompanies: [String:URL]!
    
    // Test Init
    init(){
        for i in 0..<10 {
            let url = URL(fileURLWithPath: "http://www.telus.ca")
            let name = "Telus \(String(i))"
            allCompanies["\(name)"] = url
        }
    }
    
}
