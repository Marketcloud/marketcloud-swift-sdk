import Foundation

internal class Categories {
    
    private var headers:[String : String]
    
    internal init(key: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":key]
    }
    
    internal init(key: String, token: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":"\(key):\(token)"]
    }
    
    internal func getCategories() -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard let shouldReturn:HTTPResult = Just.get("http://api.marketcloud.it/v0/categories", headers:headers) else {
            return [
                "Error in Just.get" : "Critical Error in HTTP request"]
        }
        
        if (shouldReturn.json == nil) {
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    internal func getCategoryById(id:Int) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        guard let shouldReturn:HTTPResult = Just.get("http://api.marketcloud.it/v0/categories/\(id)", headers:headers) else {
            return[
                "Error in Just.get" : "Critical Error in HTTP request"]
        }
        
        if (shouldReturn.json == nil) {
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    
    
}
