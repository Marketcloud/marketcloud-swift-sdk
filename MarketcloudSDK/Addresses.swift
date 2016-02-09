import Foundation

class Addresses  {
    private var headers:[String : String]
    
    internal init(key: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":key]
        
    }
    
    internal init(key: String, token: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":"\(key):\(token)"]
    }
    
    internal func createAddress(var datas:[String:AnyObject]) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard (datas["full_name"] != nil && datas["full_name"] as! String != ""  ) else {
            print("ERROR: Missing 'full_name' field")
            return [
                "Error" : "'full_name' field MUST be filled"]
        }
        
        guard (datas["country"] != nil && datas["country"] as! String != ""  ) else {
            print("ERROR: Missing 'country' field")
            return [
                "Error" : "'country' field MUST be filled"]
        }
        
        guard (datas["state"] != nil && datas["state"] as! String != ""  ) else {
            print("ERROR: Missing 'state' field")
            return [
                "Error" : "'state' field MUST be filled"]
        }
        
        guard (datas["city"] != nil && datas["city"] as! String != ""  ) else {
            print("ERROR: Missing 'city' field")
            return [
                "Error" : "'city' field MUST be filled"]
        }
        
        guard (datas["address1"] != nil && datas["address1"] as! String != ""  ) else {
            print("ERROR: Missing 'address1' field")
            return [
                "Error" : "'address1' field MUST be filled"]
        }
        
        guard (datas["postal_code"] != nil && datas["postal_code"] as! String != ""  ) else {
            print("ERROR: Missing 'postal_code' field")
            return [
                "Error" : "'postal_code' field MUST be filled"]
        }
        
        guard (datas["email"] != nil && datas["email"] as! String != ""  ) else {
            print("ERROR: Missing 'email' field")
            return [
                "Error" : "'email' field MUST be filled"]
        }
        
        if (datas["address2"] == nil) {
            datas["address2"] = ""
        }
        
        if (datas["phone_number"] == nil) {
            datas["phone_number"] = ""
        }
        
        if (datas["alternate_phone_number"] == nil) {
            datas["alternate_phone_number"] = ""
        }
        
        print("SENT -> \(datas)")
        
        guard let shouldReturn:HTTPResult = Just.post("http://api.marketcloud.it/v0/addresses", headers:headers, data: datas) else {
            return[
                "Error in Just.post" : "Critical Error in HTTP request"]
        }
        print("shouldReturn -> \(shouldReturn)")
        if (shouldReturn.json == nil) {
            print(shouldReturn.reason)
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    internal func getAddresses() -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard let shouldReturn:HTTPResult = Just.get("http://api.marketcloud.it/v0/addresses", headers:headers) else {
            return [
                "Error in Just.get" : "Critical Error in HTTP request"]
        }
        
        if (shouldReturn.json == nil) {
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        return shouldReturn.json as! NSDictionary
    }
    
    internal func getAddress(addressId:Int) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard let shouldReturn:HTTPResult = Just.get("http://api.marketcloud.it/v0/addresses/\(addressId)", headers:headers) else {
            return [
                "Error in Just.get" : "Critical Error in HTTP request"]
        }
        
        if (shouldReturn.json == nil) {
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        return shouldReturn.json as! NSDictionary
    }
    
    internal func updateAddress(addressId:Int, var datas:[String:AnyObject]) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard (datas["full_name"] != nil && datas["full_name"] as! String != ""  ) else {
            print("ERROR: Missing 'full_name' field")
            return [
                "Error" : "'full_name' field MUST be filled"]
        }
        
        guard (datas["country"] != nil && datas["country"] as! String != ""  ) else {
            print("ERROR: Missing 'country' field")
            return [
                "Error" : "'country' field MUST be filled"]
        }
        
        guard (datas["state"] != nil && datas["state"] as! String != ""  ) else {
            print("ERROR: Missing 'state' field")
            return [
                "Error" : "'state' field MUST be filled"]
        }
        
        guard (datas["city"] != nil && datas["city"] as! String != ""  ) else {
            print("ERROR: Missing 'city' field")
            return [
                "Error" : "'city' field MUST be filled"]
        }
        
        guard (datas["address1"] != nil && datas["address1"] as! String != ""  ) else {
            print("ERROR: Missing 'address1' field")
            return [
                "Error" : "'address1' field MUST be filled"]
        }
        
        guard (datas["postal_code"] != nil && datas["postal_code"] as! String != ""  ) else {
            print("ERROR: Missing 'postal_code' field")
            return [
                "Error" : "'postal_code' field MUST be filled"]
        }
        
        guard (datas["email"] != nil && datas["email"] as! String != ""  ) else {
            print("ERROR: Missing 'email' field")
            return [
                "Error" : "'email' field MUST be filled"]
        }
        print("SENT -> \(datas)")
        
        guard let shouldReturn:HTTPResult = Just.put("http://api.marketcloud.it/v0/addresses/\(addressId)", headers:headers, data: datas) else {
            return[
                "Error in Just.put" : "Critical Error in HTTP request"]
        }
        print("shouldReturn -> \(shouldReturn)")
        if (shouldReturn.json == nil) {
            print(shouldReturn.reason)
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    
    internal func removeAddress(addressId:Int) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        print("Sending a DELETE to http://api.marketcloud.it/v0/addresses/\(addressId)")
        
        guard let shouldReturn:HTTPResult = Just.delete("http://api.marketcloud.it/v0/addresses/\(addressId)", headers: headers) else {
            return[
                "Error in Just.delete" : "Critical Error in HTTP request"]
        }
        print("returning \(shouldReturn)")
        
        if (shouldReturn.json == nil) {
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        return shouldReturn.json as! NSDictionary
    }
}