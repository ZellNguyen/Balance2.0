//
//  FoodTag.swift
//  Balance2.0
//
//  Created by Hoa Nguyen on 2016-11-21.
//  Copyright © 2016 Hoa Nguyen. All rights reserved.
//

import UIKit

struct FoodTag {
    var name: String!
    var date: Date? = nil
    
    init(name: String) {
        self.name = name
        self.date = nil
    }
    
    init(name: String, date: Date){
        self.name = name
        self.date = date
    }
    
    func instantiate() -> FoodTag {
        let date = Date()
        return FoodTag(name: self.name, date: date)
    }
}

class FoodTagList {
    var foodTags = [FoodTag]()
    

    convenience init(force: Bool) {
        self.init()
        foodTags = [FoodTag(name: "Processed"), FoodTag(name: "Unprocessed"), FoodTag(name: "Junk food"), FoodTag(name: "Carbohydrate"), FoodTag(name: "Grain"), FoodTag(name: "Vegetables"), FoodTag(name: "Proteins"), FoodTag(name: "Fruits"), FoodTag(name: "Organic"), FoodTag(name: "Fish"), FoodTag(name: "Red meat"), FoodTag(name: "White meat"), FoodTag(name: "No meat"), FoodTag(name: "Dessert"), FoodTag(name: "Alcohol"), FoodTag(name: "Dairy"), FoodTag(name: "Sugar free"), FoodTag(name: "Fibre"), FoodTag(name: "Low sodium"), FoodTag(name: "Trans fat free"), FoodTag(name: "Gluten free"), FoodTag(name: "Low fat"), FoodTag(name: "Fatfree")]
    }
    
    static var main = FoodTagList(force: true)
    
    static var logged = FoodTagList()
    
    func add(tag: FoodTag) {
        self.foodTags.append(tag)
    }
    
    func remove(tag: FoodTag) {
        let index = self.foodTags.index(where: { (foodTag: FoodTag) in
            return tag.name == foodTag.name
        })
        
        if index != nil {
            self.foodTags.remove(at: index!)
        }
    }
    
    func add(tags: FoodTagList){
        for tag in tags.foodTags {
            self.foodTags.append(tag)
        }
    }

}
