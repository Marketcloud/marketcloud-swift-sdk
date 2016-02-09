import Foundation

class Orders {
    private var headers:[String : String]
    
    internal init(key: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":key]
    }
    
    internal init(key: String, token: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":"\(key):\(token)"]
    }
    
    //aggiunge un ORDINE
    internal func createOrder(shippingId:Int, billingId:Int, items:NSArray) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        /*
        Types.Order = new Schematic.Schema('Order', {
        "shipping_address_id" : {type : "number", required : true},
        "billing_address_id" : {type : "number", required : true},
        "items" : {type : "array", required:true},
        })*/
        
        var finalArray = [String:AnyObject]()
        finalArray["shipping_address_id"] = shippingId
        finalArray["billing_address_id"] = billingId
        finalArray["items"] = items
        
        guard let shouldReturn:HTTPResult = Just.post("Http://api.marketcloud.it/v0/orders", headers:headers, data:finalArray) else {
            return[
                "Error in Just.patch" : "Critical Error in HTTP request"]
        }
        
        if (shouldReturn.json == nil) {
            print(shouldReturn.reason)
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        
        return shouldReturn.json as! NSDictionary
    }
}
