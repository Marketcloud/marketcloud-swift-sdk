import Foundation

internal class Shippings {
    
    fileprivate var headers:[String : String]
    
    internal init(key: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":key]
    }
    
    internal init(key: String, token: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":"\(key):\(token)"]
    }
    internal func getShippings() -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard let shouldReturn:HTTPResult = Just.get("https://api.marketcloud.it/v0/shippings", headers:headers) else {
            return[
                "Error" : "Critical Error in HTTP request (get)"]
        }
        
        if (shouldReturn.json == nil) {
            print(shouldReturn.reason)
            return [
                "Error" : "Returned JSON is nil"]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    internal func getShippingById(_ id:Int) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard let shouldReturn:HTTPResult = Just.get("https://api.marketcloud.it/v0/shippings/\(id)", headers:headers) else {
            return[
                "Error" : "Critical Error in HTTP request (get)"]
        }
        
        if (shouldReturn.json == nil) {
            print(shouldReturn.reason)
            return [
                "Error" : "Returned JSON is nil"]
        }
        
        return shouldReturn.json as! NSDictionary
    }
}
