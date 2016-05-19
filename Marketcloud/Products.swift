import Foundation

internal class Product {
    
    private var headers:[String : String]
    
    internal init(key: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":key]
    }
    
    internal init(key: String, token: String) {
        headers = ["accept":"application/json","content-type":"application/json","authorization":"\(key):\(token)"]
    }
    
    internal func getProducts() -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        guard let shouldReturn:HTTPResult = Just.get("https://api.marketcloud.it/v0/products", headers:headers) else {
            return [
                "Error" : "Critical Error in HTTP request (get)"]
        }
        if (shouldReturn.json == nil) {
            return [
                "Error" : "Returned JSON is nil"]
        }
        return shouldReturn.json as! NSDictionary
    }
    
    internal func getProducts(filters:[String: AnyObject]) -> NSDictionary {
        let queryString = filters.stringFromHttpParameters()
        
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        print("Query url is https://api.marketcloud.it/v0/products?\(queryString)")
        guard let shouldReturn:HTTPResult = Just.get("https://api.marketcloud.it/v0/products?\(queryString)", headers:headers) else {
            return [
                "Error" : "Critical Error in HTTP request (get)"]
        }
        if (shouldReturn.json == nil) {
            return [
                "Error" : "Returned JSON is nil"]
        }
        return shouldReturn.json as! NSDictionary
    }

    internal func getProductById(id:Int) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "Error" : "No Connection"]
        }
        guard let shouldReturn:HTTPResult = Just.get("https://api.marketcloud.it/v0/products/\(id)", headers:headers) else {
            return[
                "Error" : "Critical Error in HTTP request (get)"]
        }
        
        if (shouldReturn.json == nil) {
            return [
                "Error" : "Returned JSON is nil"]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
    internal func getProductsByCategory(categoryId:Int) -> NSDictionary {
        guard Reachability.isConnectedToNetwork() == true else {
            return [
                "error" : "No Connection"]
        }
        guard let shouldReturn:HTTPResult = Just.get("https://api.marketcloud.it/v0/products?category_id=\(categoryId)", headers: headers) else {
            return[
                "Error" : "Critical Error in HTTP request (get)"]
        }
        
        if (shouldReturn.json == nil) {
            return [
                "Error" : "Returned JSON is nil"]
        }
        
        return shouldReturn.json as! NSDictionary
    }
    
}