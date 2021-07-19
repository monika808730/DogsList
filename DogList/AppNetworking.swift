import UIKit
import SystemConfiguration


class AppNetworking
{
    static let shared = AppNetworking()
    static let noInternetError = NSError(domain: "NetworkCheck", code: 500, userInfo: ["ErrorDescription":"Check your internet connection."])
    static var isConnectedToNetwork : Bool {
        return Reachability.shared!.isReachable
    }
    
    func APICalling(apiUrl:String,
                    successResp : @escaping success,
                    failure : @escaping Failure)
    {
        let request = NSMutableURLRequest(url: NSURL(string: apiUrl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        guard AppNetworking.isConnectedToNetwork else {
            failure(AppNetworking.noInternetError)
            return
        }
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            do{
                guard let datas = data else {
                    print(String(describing: error))
                    return
                }
                if let jsonResp = try JSONSerialization.jsonObject(with: datas, options: .allowFragments) as? JSONDictionary{
                    
                    successResp([jsonResp])
                    
                }else if let jsonResp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [JSONDictionary]{
                    
                    successResp(jsonResp)
                    
                }else{
                    failure(error! as NSError)
                }
                
                
            }catch{
            }
        })
        
        dataTask.resume()
    }
}
