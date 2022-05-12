import UIKit
import SystemConfiguration


public class AppNetworking
{
    static let shared = AppNetworking()
    static let noInternetError = NSError(domain: "NetworkCheck", code: 500, userInfo: ["ErrorDescription":"Check your internet connection."])
    static let somethingWentWrongError = NSError(domain: "Error", code: 404, userInfo: ["ErrorDescription":"Something went wrong."])
    static var isConnectedToNetwork : Bool {
        return Reachability.shared!.isReachable
    }
}

// Call API And get response.
func getAPIReponse(url:String, completion: @escaping (_ data: [JSONDictionary]?, _ error: String?) -> Void) {
    
    guard let apiUrl = URL(string: url) else { return }
    
    var request = URLRequest(url: apiUrl,timeoutInterval: 100)
    request.httpMethod = "GET"
    request.addValue(apiKey, forHTTPHeaderField: "x-api-key")

    guard AppNetworking.isConnectedToNetwork else {
        completion(nil,AppNetworking.noInternetError.description)
        return
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else { return }
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [JSONDictionary]{
                completion(json,nil)
            }else{
                completion(nil,"error")
            }
        }catch{
            completion(nil, "error")
        }
    }
    
    task.resume()
}
