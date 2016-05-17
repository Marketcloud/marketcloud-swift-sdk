import Foundation

internal class Orders {
    private var headers:[String : String]
    
    internal init(key: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":key]
    }
    
    internal init(key: String, token: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":"\(key):\(token)"]
    }
    
    //adds an order
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
        
        guard let shouldReturn:HTTPResult = Just.post("https://api.marketcloud.it/v0/orders", headers:headers, data:finalArray) else {
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
    
    //complete an order sending the stripeToken to the API
    internal func completeOrder(orderId:Int, stripeToken:String) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        var finalArray = [String:AnyObject]()
        finalArray["order_id"] = orderId
        finalArray["source"] = stripeToken
        
        guard let shouldReturn:HTTPResult = Just.post("https://api.marketcloud.it/v0/integrations/stripe/charges", headers:headers, data:finalArray) else {
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
}