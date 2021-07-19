
import UIKit


let apiKey = "4c4886ba-8b55-44ad-9b66-96fc4362c986"
let baseUrl = "https://api.thedogapi.com/v1/breeds"

typealias JSONDictionary = [String: Any]
internal typealias Failure = ((_ error : NSError) -> Void)
internal typealias success = (([JSONDictionary]) -> Void)

