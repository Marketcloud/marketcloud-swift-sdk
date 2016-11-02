import Foundation

internal class Carts {
    
    fileprivate var headers:[String : String]
    
    internal init(key: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":key]
    }
    
    internal init(key: String, token: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":"\(key):\(token)"]
    }
    
    //Creates cart------------------------------------
    internal func createEmptyCart() -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        //print("creating a cart for unlogged user")
        let myDictOfDict = [
            "items" : [NSDictionary]()
        ]
        
        guard let shouldReturn:HTTPResult = Just.post("https://api.marketcloud.it/v0/carts", data: myDictOfDict, headers:headers) else {
            return[
                "Error" : "Critical Error in HTTP request (post)"]
        }
        
        if (shouldReturn.json == nil) {
            //print(shouldReturn.reason)
            return [
                "Error" : "Returned JSON is nil"]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    //retrieves a cart by its id
    internal func getCart(_ id:Int) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard let shouldReturn:HTTPResult = Just.get("https://api.marketcloud.it/v0/carts/\(id)", headers:headers) else {
            return[
                "Error" : "Critical Error in HTTP request (get)"]
        }
        
        if (shouldReturn.json == nil) {
            //print(shouldReturn.reason)
            return [
                "Error" : "Returned JSON is nil"]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    //retrieves logged user cart
    internal func getCart() -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard let shouldReturn:HTTPResult = Just.get("https://api.marketcloud.it/v0/carts/", headers:headers) else {
            return[
                "Error" : "Critical Error in HTTP request (get)"]
        }
        
        if (shouldReturn.json == nil) {
            //print(shouldReturn.reason)
            return [
                "Error" : "Returned JSON is nil"]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    
    //adds a product to a cart
    internal func addToCart(_ cartId:Int, data:[Any]) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        var finalArray = [String:Any]()
        finalArray["op"] = "add" as Any?
        finalArray["items"] = data as Any?
        
        guard let shouldReturn:HTTPResult = Just.patch("https://api.marketcloud.it/v0/carts/\(cartId)", data:finalArray, headers:headers) else {
            return[
                "Error" : "Critical Error in HTTP request (patch)"]
        }
        
        if (shouldReturn.json == nil) {
            //print(shouldReturn.reason)
            return [
                "Error" : "Returned JSON is nil"]
        }
        
        return shouldReturn.json as! NSDictionary
    }

    //updates object's quantity
    internal func updateCart(_ cartId:Int, data:[Any]) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        var finalArray = [String:Any]()
        finalArray["op"] = "update" as Any?
        finalArray["items"] = data as Any?
        
        guard let shouldReturn:HTTPResult = Just.patch("https://api.marketcloud.it/v0/carts/\(cartId)", data:finalArray, headers:headers) else {
            return[
                "Error" : "Critical Error in HTTP request (patch)"]
        }
        
        if (shouldReturn.json == nil) {
            //print(shouldReturn.reason)
            return [
                "Error" : "Returned JSON is nil"]
        }
        return shouldReturn.json as! NSDictionary
    }
    
    //removes an object from a cart
    internal func removeFromCart(_ cartId:Int, data:[Any]) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        var finalArray = [String:Any]()
        finalArray["op"] = "remove" as Any?
        finalArray["items"] = data as Any?
        
        guard let shouldReturn:HTTPResult = Just.patch("https://api.marketcloud.it/v0/carts/\(cartId)", data:finalArray, headers:headers) else {
            return[
                "Error" : "Critical Error in HTTP request (patch)"]
        }
        
        if (shouldReturn.json == nil) {
            //print(shouldReturn.reason)
            return [
                "Error" : "Returned JSON is nil"]
        }
        return shouldReturn.json as! NSDictionary
    }
}
