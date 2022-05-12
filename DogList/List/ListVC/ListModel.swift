//
//  ListModel.swift
//  DogList
//
//  Created by Monika on 12/05/2022.
//

import Foundation

struct ListsModel{

    var dogsList = [DogsListModel]()
    
    init(json: [JSONDictionary]) {
        
        for js in json{
            let model = DogsListModel(json: js)
            dogsList.append(model)
        }
    }
}

struct DogsListModel{
    var name = ""
    var breed_group = ""
    var imgURL = ""
    var temperament = ""
    var bred_for = ""
    var life_span = ""
    var height_metric_imperial = ""
    var weight_metric_imperial = ""
    
    init(json:JSONDictionary){
        self.name = json["name"] as? String ?? ""
        self.breed_group = json["breed_group"] as? String ?? ""
        if let imageDict = json["image"] as? JSONDictionary{
            if let imageURL = imageDict["url"] as? String{
                imgURL = imageURL
            }
        }
        
        self.temperament = json["temperament"] as? String ?? "N/A"
        self.bred_for = json["bred_for"] as? String ?? "N/A"
        self.life_span = json["life_span"] as? String ?? "N/A"
        
        if let heightDict = json["height"] as? JSONDictionary{
            let metric = heightDict["metric"] as? String ?? "N/A"
            let imperial = heightDict["imperial"] as? String ?? "N/A"
            
            height_metric_imperial = "Metric : \(metric) \nImperial : \(imperial)"
        }
        
        if let weightDict = json["weight"] as? JSONDictionary{
            let metric = weightDict["metric"] as? String ?? "N/A"
            let imperial = weightDict["imperial"] as? String ?? "N/A"
            
            weight_metric_imperial = "Metric : \(metric) \nImperial : \(imperial)"
        }

    }
}
