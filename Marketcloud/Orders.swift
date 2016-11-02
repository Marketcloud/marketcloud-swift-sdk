import Foundation

internal class Orders {
    fileprivate var headers:[String : String]
    
    internal init(key: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":key]
    }
    
    internal init(key: String, token: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":"\(key):\(token)"]
    }
    
    //adds an order
    internal func createOrder(_ shippingId:Int, billingId:Int, cart_id:Int) -> NSDictionary {
        
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
        
        var finalArray = [String:Int]()
        finalArray["shipping_address_id"] = shippingId
        finalArray["billing_address_id"] = billingId
        finalArray["cart_id"] = cart_id 
        
        print("Final array from SDK --> createOrder")
        print(finalArray)
        
        guard let shouldReturn:HTTPResult = Just.post("https://api.marketcloud.it/v0/orders", data:finalArray, headers:headers) else {
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
    internal func completeOrder(_ orderId:Int, stripeToken:String) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        var finalArray = [String:Any]()
        finalArray["order_id"] = orderId as Any?
        finalArray["source"] = stripeToken as Any?
        
        guard let shouldReturn:HTTPResult = Just.post("https://api.marketcloud.it/v0/integrations/stripe/charges", data:finalArray, headers:headers) else {
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
