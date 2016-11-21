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
}

class FoodTagList {
    var foodTags = [FoodTag]()
    
    init() {
        foodTags = [FoodTag(name: "Processed"), FoodTag(name: "Unprocessed"), FoodTag(name: "Junk food"), FoodTag(name: "Carbohydrate"), FoodTag(name: "Grain"), FoodTag(name: "Vegetables"), FoodTag(name: "Proteins"), FoodTag(name: "Fruits"), FoodTag(name: "Organic"), FoodTag(name: "Fish"), FoodTag(name: "Red meat"), FoodTag(name: "White meat"), FoodTag(name: "No meat"), FoodTag(name: "Dessert"), FoodTag(name: "Alcohol"), FoodTag(name: "Dairy"), FoodTag(name: "Sugar free"), FoodTag(name: "Fibre"), FoodTag(name: "Low sodium"), FoodTag(name: "Trans fat free"), FoodTag(name: "Gluten free"), FoodTag(name: "Low fat"), FoodTag(name: "Fatfree")]
    }
    
    func add(foodTag: FoodTag) {
        foodTags.append(foodTag)
    }
    static var main = FoodTagList()
}
