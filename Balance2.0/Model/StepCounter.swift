//
//  StepCounter.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-16.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import Foundation
import HealthKit

class StepCounter {
    let storage: HKHealthStore! = HKHealthStore()
    var steps: Int! = 0
    
    func authorizeHealthKit(completion: ((_ success: Bool, _ error: NSError?) -> Void)!) {
        let step = Set(arrayLiteral: HKQuantityType.quantityType(forIdentifier: .stepCount)!)
        
        if !HKHealthStore.isHealthDataAvailable() {
            let error = NSError(domain: NSCocoaErrorDomain, code: NSURLErrorNoPermissionsToReadFile, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
            
            if(completion != nil) {
                completion?(false, error)
            }
            return
        }
        
        storage.requestAuthorization(toShare: nil, read: step, completion: { (success, error) -> Void in
            if completion != nil {
                completion?(success, error as? NSError)
            }
        })
        
    }
    
    func recentSteps(_ startTime: Date, completion: ((Double, NSError?) -> Void)! ) {
        let type = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        let predicate  = HKQuery.predicateForSamples(withStart: startTime, end: NSDate() as Date, options: .strictEndDate)
        
        let query  = HKSampleQuery(sampleType: type!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { query, results, error in
            var steps: Double = 0
            
            if (results?.count)! > 0 {
                for result in results as! [HKQuantitySample] {
                    steps += result.quantity.doubleValue(for: HKUnit.count())
                }
            }
            completion(steps, error as NSError?)
        })
        
        storage.execute(query)
    }

    static var startTime: NSDate!
    static var main = StepCounter()
}
