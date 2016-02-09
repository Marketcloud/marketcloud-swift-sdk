import Foundation

public class Users {
    
    private var headers:[String : String]
    private var loggedIn:Bool
    
    internal init(key: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":key]
        loggedIn = false
    }
    
    internal init(key: String, token: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":"\(key):\(token)"]
        loggedIn = true
    }
    
    
    
    internal func createUser(var datas:[String:String]) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard (datas["email"] != nil && datas["email"] != ""  ) else {
            print("ERROR: Missing 'email' field")
            return [
                "Error" : "'email' field MUST be filled"]
        }
        
        guard (datas["name"] != nil && datas["name"]  != ""  ) else {
            
            print("ERROR: Missing 'name' field")
            return [
                "Error" : "'name' field MUST be filled"]
        }
        
        guard (datas["password"] != nil && datas["password"] != ""  ) else {
            print("ERROR: Missing 'password' field")
            return [
                "Error" : "'password' field MUST be filled"]
        }
        
        if (datas["image_url"] == nil) {
            datas["image_url"] = ""
        }
        
        guard let shouldReturn:HTTPResult = Just.post("http://api.marketcloud.it/v0/users", headers:headers, data: datas) else {
            return[
                "Error in Just.post" : "Critical Error in HTTP request"]
        }
        
        if (shouldReturn.json == nil) {
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    internal func logIn(datas:[String:String]) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard (datas["email"] != nil && datas["email"] != "" ) else {
            print("ERROR: Missing 'email' field")
            return [
                "Error" : "'email' field MUST be filled"]
        }
        guard (datas["password"] != nil && datas["password"] != "" ) else {
            print("ERROR: Missing 'password' field")
            return [
                "Error" : "'password' field MUST be filled"]
        }
        
        guard let shouldReturn:HTTPResult = Just.post("http://api.marketcloud.it/v0/users/authenticate", headers:headers, data: datas) else {
            return[
                "Error in Just.post" : "Critical Error in HTTP request"]
        }
        
        if (shouldReturn.json == nil) {
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        if (shouldReturn.json!["status"] as! Bool == false) {
            return ["Error (status == 0)":"Wrong credentials"]
        }
        print(shouldReturn.json!)
        
        let token:String = String(shouldReturn.json!["data"]!!["token"]!!)
        let userId:String = String(shouldReturn.json!["data"]!!["user"]!!["id"]!!)
        
        return ["token":token, "user_id":userId]
    }
    
    internal func logOut() -> Bool {
        if(loggedIn) {
            return true
        } else {
            return false
        }
    }
    
    
    internal func updateUser(var datas:[String:String], userId:Int) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard (datas["email"] != nil && datas["email"] != ""  ) else {
            print("ERROR: Missing 'email' field")
            return [
                "Error" : "'email' field MUST be filled"]
        }
        
        guard (datas["name"] != nil && datas["name"]  != ""  ) else {
            
            print("ERROR: Missing 'name' field")
            return [
                "Error" : "'name' field MUST be filled"]
        }
        
        guard (datas["password"] != nil && datas["password"] != ""  ) else {
            print("ERROR: Missing 'password' field")
            return [
                "Error" : "'password' field MUST be filled"]
        }
        
        guard let shouldReturn:HTTPResult = Just.put("http://api.marketcloud.it/v0/users/\(userId)", headers:headers, data: datas) else {
            return[
                "Error in Just.put" : "Critical Error in HTTP request"]
        }
        
        if (shouldReturn.json == nil) {
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        
        return shouldReturn.json as! NSDictionary
    }
}