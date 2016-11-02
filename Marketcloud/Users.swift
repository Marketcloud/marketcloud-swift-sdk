import Foundation

internal class Users {
    
    fileprivate var headers:[String : String]
    fileprivate var loggedIn:Bool
    
    internal init(key: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":key]
        loggedIn = false
    }
    
    internal init(key: String, token: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":"\(key):\(token)"]
        loggedIn = true
    }
    
    internal func createUser(_ datas:[String:String]) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard (datas["email"] != nil && datas["email"] != ""  ) else {
            //print("ERROR: Missing 'email' field")
            return [
                "Error" : "'email' field MUST be filled"]
        }
        
        guard (datas["name"] != nil && datas["name"]  != ""  ) else {
            
            //print("ERROR: Missing 'name' field")
            return [
                "Error" : "'name' field MUST be filled"]
        }
        
        guard (datas["password"] != nil && datas["password"] != ""  ) else {
            //print("ERROR: Missing 'password' field")
            return [
                "Error" : "'password' field MUST be filled"]
        }
        
        var newDatas = datas
        
        if (datas["image_url"] == nil) {
            newDatas["image_url"] = ""
        }
        
        guard let shouldReturn:HTTPResult = Just.post("https://api.marketcloud.it/v0/users", data: datas as [String : Any], headers:headers) else {
            return[
                "Error" : "Critical Error in HTTP request (post)"]
        }
        
        if (shouldReturn.json == nil) {
            return [
                "Error" : "Returned JSON is nil"]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    internal func logIn(_ datas:[String:String]) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard (datas["email"] != nil && datas["email"] != "" ) else {
            //print("ERROR: Missing 'email' field")
            return [
                "Error" : "'email' field MUST be filled"]
        }
        guard (datas["password"] != nil && datas["password"] != "" ) else {
            //print("ERROR: Missing 'password' field")
            return [
                "Error" : "'password' field MUST be filled"]
        }
        
        guard let shouldReturn:HTTPResult = Just.post("https://api.marketcloud.it/v0/users/authenticate", data: datas as [String : Any], headers:headers) else {
            return[
                "Error" : "Critical Error in HTTP request (post)"]
        }
        
        if (shouldReturn.json == nil) {
            return [
                "Error" : "Returned JSON is nil"]
        }
        
        var test  = shouldReturn.json as? [String:Any]
        if (test?["status"]! as! Bool == false) {
            return ["Error":"Wrong credentials"]
        }
        
        var boolTest:Bool = (((shouldReturn.json! as? NSDictionary)?["status"]) != nil)
        
        //print("BoolTest printing...")
        //print(boolTest)

        if (boolTest == false) {
            return ["Error":"Wrong credentials"]
        }
        //print(shouldReturn.json!)
        
        let data:NSDictionary = (shouldReturn.json as! NSDictionary)["data"]! as! NSDictionary
        
        let token = data["token"]!
       // print("Printing token")
       // print(token)
        
        let userdata:NSDictionary = data["user"] as! NSDictionary
        let userId = userdata["id"]!
       // print("Printing id")
       // print(userId)


        //return ["token":token, "user_id":userId]
        return ["token":token, "user_id":userId]
    }
    
    
    internal func logOut() -> Bool {
        if(loggedIn) {
            return true
        } else {
            return false
        }
    }
    
    
    internal func updateUser(_ datas:[String:String], userId:Int) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard (datas["email"] != nil && datas["email"] != ""  ) else {
            //print("ERROR: Missing 'email' field")
            return [
                "Error" : "'email' field MUST be filled"]
        }
        
        guard (datas["name"] != nil && datas["name"]  != ""  ) else {
            
            //print("ERROR: Missing 'name' field")
            return [
                "Error" : "'name' field MUST be filled"]
        }
        
        guard (datas["password"] != nil && datas["password"] != ""  ) else {
            //print("ERROR: Missing 'password' field")
            return [
                "Error" : "'password' field MUST be filled"]
        }
        
        guard let shouldReturn:HTTPResult = Just.put("https://api.marketcloud.it/v0/users/\(userId)", data: datas as [String : Any], headers:headers) else {
            return[
                "Error" : "Critical Error in HTTP request (put)"]
        }
        
        if (shouldReturn.json == nil) {
            return [
                "Error" : "Returned JSON is nil"]
        }
        
        return shouldReturn.json as! NSDictionary
    }
}
