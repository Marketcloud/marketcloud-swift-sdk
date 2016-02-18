import Foundation

internal class Carts {
    
    private var headers:[String : String]
    
    internal init(key: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":key]
    }
    
    internal init(key: String, token: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":"\(key):\(token)"]
    }
    
    //CREAZIONE CARRELLO------------------------------------
    internal func createEmptyCart() -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        print("Creo carrello per utente non loggato")
        let myDictOfDict = [
            "items" : [NSDictionary]()
        ]
        
        guard let shouldReturn:HTTPResult = Just.post("http://api.marketcloud.it/v0/carts", headers:headers, data: myDictOfDict) else {
            return[
                "Error in Just.post" : "Critical Error in HTTP request"]
        }
        
        if (shouldReturn.json == nil) {
            print(shouldReturn.reason)
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    //recupera carrello da id (principalmente per utenti non loggati)
    internal func getCart(id:Int) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard let shouldReturn:HTTPResult = Just.get("http://api.marketcloud.it/v0/carts/\(id)", headers:headers) else {
            return[
                "Error in Just.get" : "Critical Error in HTTP request"]
        }
        
        if (shouldReturn.json == nil) {
            print(shouldReturn.reason)
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    //recupera L'ULTIMO carrello dell'utente (solo se loggato)
    internal func getCart() -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        guard let shouldReturn:HTTPResult = Just.get("http://api.marketcloud.it/v0/carts/", headers:headers) else {
            return[
                "Error in Just.get" : "Critical Error in HTTP request"]
        }
        
        if (shouldReturn.json == nil) {
            print(shouldReturn.reason)
            return [
                "Error (shouldReturn.json == nil)" : shouldReturn.reason]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    
    //aggiunge un oggetto al carrello (somma se oggetto è già esistente)
    internal func addToCart(cartId:Int, data:[AnyObject]) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        var finalArray = [String:AnyObject]()
        finalArray["op"] = "add"
        finalArray["items"] = data
        
        guard let shouldReturn:HTTPResult = Just.patch("http://api.marketcloud.it/v0/carts/\(cartId)", headers:headers, data:finalArray) else {
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
    
    //aggiorna quantità di un oggetto nel carrello (o lo aggiunge se oggetto non è presente)
    internal func updateCart(cartId:Int, data:[AnyObject]) -> NSDictionary {
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        var finalArray = [String:AnyObject]()
        finalArray["op"] = "update"
        finalArray["items"] = data
        
        guard let shouldReturn:HTTPResult = Just.patch("http://api.marketcloud.it/v0/carts/\(cartId)", headers:headers, data:finalArray) else {
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
    
    //aggiorna quantità di un oggetto nel carrello (o lo aggiunge se oggetto non è presente)
    internal func removeFromCart(cartId:Int, data:[AnyObject]) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        
        var finalArray = [String:AnyObject]()
        finalArray["op"] = "remove"
        finalArray["items"] = data
        
        guard let shouldReturn:HTTPResult = Just.patch("http://api.marketcloud.it/v0/carts/\(cartId)", headers:headers, data:finalArray) else {
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