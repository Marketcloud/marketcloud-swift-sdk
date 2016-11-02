import Foundation

internal class Addresses  {
    fileprivate var headers:[String : String]
    
    internal init(key: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":key]
        
    }
    
    internal init(key: String, token: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":"\(key):\(token)"]
    }
    
    internal func createAddress(_ datas:[String:Any]) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard (datas["full_name"] != nil && datas["full_name"] as! String != ""  ) else {
            //print("ERROR: Missing 'full_name' field")
            return [
                "Error" : "'full_name' field MUST be filled"]
        }
        
        guard (datas["country"] != nil && datas["country"] as! String != ""  ) else {
            //print("ERROR: Missing 'country' field")
            return [
                "Error" : "'country' field MUST be filled"]
        }
        
        guard (datas["state"] != nil && datas["state"] as! String != ""  ) else {
            //print("ERROR: Missing 'state' field")
            return [
                "Error" : "'state' field MUST be filled"]
        }
        
        guard (datas["city"] != nil && datas["city"] as! String != ""  ) else {
            //print("ERROR: Missing 'city' field")
            return [
                "Error" : "'city' field MUST be filled"]
        }
        
        guard (datas["address1"] != nil && datas["address1"] as! String != ""  ) else {
            //print("ERROR: Missing 'address1' field")
            return [
                "Error" : "'address1' field MUST be filled"]
        }
        
        guard (datas["postal_code"] != nil && datas["postal_code"] as! String != ""  ) else {
            //print("ERROR: Missing 'postal_code' field")
            return [
                "Error" : "'postal_code' field MUST be filled"]
        }
        
        guard (datas["email"] != nil && datas["email"] as! String != ""  ) else {
            //print("ERROR: Missing 'email' field")
            return [
                "Error" : "'email' field MUST be filled"]
        }
        
        var updatedDatas = datas
        
        if (datas["address2"] == nil) {
            updatedDatas["address2"] = "" as Any?
        }
        
        if (datas["phone_number"] == nil) {
            updatedDatas["phone_number"] = "" as Any?
        }
        
        if (datas["alternate_phone_number"] == nil) {
            updatedDatas["alternate_phone_number"] = "" as Any?
        }
        
        //print("SENT -> \(datas)")
        
        guard let shouldReturn:HTTPResult = Just.post("https://api.marketcloud.it/v0/addresses", data: updatedDatas, headers:headers) else {
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
    
    internal func getAddresses() -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard let shouldReturn:HTTPResult = Just.get("https://api.marketcloud.it/v0/addresses", headers:headers) else {
            return [
                "Error" : "Critical Error in HTTP request (get)"]
        }
        
        if (shouldReturn.json == nil) {
            //print(shouldReturn.reason)
            return [
                "Error" : "Returned JSON is nil"]
        }
        return shouldReturn.json as! NSDictionary
    }
    
    internal func getAddress(_ addressId:Int) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard let shouldReturn:HTTPResult = Just.get("https://api.marketcloud.it/v0/addresses/\(addressId)", headers:headers) else {
            return [
                "Error" : "Critical Error in HTTP request (get)"]
        }
        
        if (shouldReturn.json == nil) {
            //print(shouldReturn.reason)
            return [
                "Error" : "Returned JSON is nil"]
        }
        return shouldReturn.json as! NSDictionary
    }
    
    internal func updateAddress(_ addressId:Int, datas:[String:Any]) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard (datas["full_name"] != nil && datas["full_name"] as! String != ""  ) else {
            //print("ERROR: Missing 'full_name' field")
            return [
                "Error" : "'full_name' field MUST be filled"]
        }
        
        guard (datas["country"] != nil && datas["country"] as! String != ""  ) else {
            //print("ERROR: Missing 'country' field")
            return [
                "Error" : "'country' field MUST be filled"]
        }
        
        guard (datas["state"] != nil && datas["state"] as! String != ""  ) else {
            //print("ERROR: Missing 'state' field")
            return [
                "Error" : "'state' field MUST be filled"]
        }
        
        guard (datas["city"] != nil && datas["city"] as! String != ""  ) else {
            //print("ERROR: Missing 'city' field")
            return [
                "Error" : "'city' field MUST be filled"]
        }
        
        guard (datas["address1"] != nil && datas["address1"] as! String != ""  ) else {
            //print("ERROR: Missing 'address1' field")
            return [
                "Error" : "'address1' field MUST be filled"]
        }
        
        guard (datas["postal_code"] != nil && datas["postal_code"] as! String != ""  ) else {
            //print("ERROR: Missing 'postal_code' field")
            return [
                "Error" : "'postal_code' field MUST be filled"]
        }
        
        guard (datas["email"] != nil && datas["email"] as! String != ""  ) else {
            //print("ERROR: Missing 'email' field")
            return [
                "Error" : "'email' field MUST be filled"]
        }
        //print("SENT -> \(datas)")
        
        guard let shouldReturn:HTTPResult = Just.put("https://api.marketcloud.it/v0/addresses/\(addressId)", data: datas, headers:headers) else {
            return[
                "Error" : "Critical Error in HTTP request (put)"]
        }
        //print("shouldReturn -> \(shouldReturn)")
        if (shouldReturn.json == nil) {
           // print(shouldReturn.reason)
            return [
                "Error" : "Returned JSON is nil"]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    
    internal func removeAddress(_ addressId:Int) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        //print("Sending a DELETE to https://api.marketcloud.it/v0/addresses/\(addressId)")
        
        guard let shouldReturn:HTTPResult = Just.delete("https://api.marketcloud.it/v0/addresses/\(addressId)", headers: headers) else {
            return[
                "Error" : "Critical Error in HTTP request (delete)"]
        }
        //print("returning \(shouldReturn)")
        
        if (shouldReturn.json == nil) {
            return [
                "Error" : "Returned JSON is nil"]
        }
        return shouldReturn.json as! NSDictionary
    }
}
