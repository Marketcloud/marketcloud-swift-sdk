import Foundation

internal class Carts {
    
    private var headers:[String : String]
    
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
        
        guard let shouldReturn:HTTPResult = Just.post("https://api.marketcloud.it/v0/carts", headers:headers, data: myDictOfDict) else {
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
    internal func getCart(id:Int) -> NSDictionary {
        
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
    internal func addToCart(cartId:Int, data:[AnyObject]) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        var finalArray = [String:AnyObject]()
        finalArray["op"] = "add"
        finalArray["items"] = data
        
        guard let shouldReturn:HTTPResult = Just.patch("https://api.marketcloud.it/v0/carts/\(cartId)", headers:headers, data:finalArray) else {
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
    internal func updateCart(cartId:Int, data:[AnyObject]) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        var finalArray = [String:AnyObject]()
        finalArray["op"] = "update"
        finalArray["items"] = data
        
        guard let shouldReturn:HTTPResult = Just.patch("https://api.marketcloud.it/v0/carts/\(cartId)", headers:headers, data:finalArray) else {
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
    internal func removeFromCart(cartId:Int, data:[AnyObject]) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        var finalArray = [String:AnyObject]()
        finalArray["op"] = "remove"
        finalArray["items"] = data
        
        guard let shouldReturn:HTTPResult = Just.patch("https://api.marketcloud.it/v0/carts/\(cartId)", headers:headers, data:finalArray) else {
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