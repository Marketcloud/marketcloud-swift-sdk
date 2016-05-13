import Foundation

public class Marketcloud {
    
    private var publicKey:String
    private var token:String
    private var user_id:Int
    
    private var products:Product
    private var categories:Categories
    private var brands:Brands
    private var carts:Carts
    private var addresses:Addresses
    private var users:Users
    private var orders:Orders
    public var utils:Utils
    
    public init(key: String) {
        publicKey = key
        token = ""
        user_id = -1
        
        products = Product(key: publicKey)
        categories = Categories(key: publicKey)
        brands = Brands(key: publicKey)
        carts = Carts(key:publicKey)
        addresses = Addresses(key:publicKey)
        users = Users(key:publicKey)
        orders = Orders(key:publicKey)
        utils = Utils()
        //these classes will be reinitialized if an user logs in
    }
    
    public func getKey() -> String {
        return self.publicKey
    }
    public func getUserId() -> Int {
        return self.user_id
    }
    public func getToken() -> String {
        return self.token
    }
    
    
    //-------------------------------------------------------
    public func getProducts() -> NSDictionary {
        return products.getProducts()
    }
    
    public func getProductById(id:Int) -> NSDictionary {
        return products.getProductById(id)
    }
    public func getProductById(id:String) -> NSDictionary {
        return products.getProductById(Int(id)!)
    }
    
    public func getProductsByCategory(id:Int) -> NSDictionary {
        return products.getProductsByCategory(id)
    }
    public func getProductsByCategory(id:String) -> NSDictionary {
        return products.getProductsByCategory(Int(id)!)
    }
    
    //-------------------------------------------------------
    public func getCategories() -> NSDictionary {
        return categories.getCategories()
    }
    
    public func getCategoryById(id:Int) -> NSDictionary {
        return categories.getCategoryById(id)
    }
    public func getCategoryById(id:String) -> NSDictionary {
        return categories.getCategoryById(Int(id)!)
    }
    //-------------------------------------------------------
    public func getBrands() -> NSDictionary {
        return brands.getBrands()
    }
    
    public func getBrandsById(id:Int) -> NSDictionary {
        return brands.getBrandById(id)
    }
    public func getBrandsById(id:String) -> NSDictionary {
        return brands.getBrandById(Int(id)!)
    }
    //-------------------------------------------------------
    public func createEmptyCart() -> NSDictionary {
        return carts.createEmptyCart()
    }
    
    public func getCart() -> NSDictionary {
        return carts.getCart()
    }
    public func getCart(id:Int) -> NSDictionary {
        return carts.getCart(id)
    }
    public func getCart(id:String) -> NSDictionary {
        return carts.getCart(Int(id)!)
    }
    
    public func addToCart(id:Int, data:[AnyObject]) -> NSDictionary {
        return carts.addToCart(id, data:data)
    }
    public func addToCart(id:String, data:[AnyObject]) -> NSDictionary {
        return carts.addToCart(Int(id)!, data:data)
    }
    
    public func updateCart(id:Int, data:[AnyObject]) -> NSDictionary {
        return carts.updateCart(id, data:data)
    }
    public func updateCart(id:String, data:[AnyObject]) -> NSDictionary {
        return carts.updateCart(Int(id)!, data:data)
    }
    
    public func removeFromCart(id:Int, data:[AnyObject]) -> NSDictionary {
        return carts.removeFromCart(id, data:data)
    }
    public func removeFromCart(id:String, data:[AnyObject]) -> NSDictionary {
        return carts.removeFromCart(Int(id)!, data:data)
    }
    
    //---------------------------------------------------------
    public func createAddress(datas:[String:AnyObject]) -> NSDictionary {
        return addresses.createAddress(datas)
    }
    
    public func getAddresses() -> NSDictionary {
        return addresses.getAddresses()
    }
    
    public func getAddress(id:Int) -> NSDictionary {
        return addresses.getAddress(id)
    }
    public func getAddress(id:String) -> NSDictionary {
        return addresses.getAddress(Int(id)!)
    }
    
    public func updateAddress(id:Int, datas:[String:AnyObject]) -> NSDictionary {
        return addresses.updateAddress(id, datas: datas)
    }
    public func updateAddress(id:String, datas:[String:AnyObject]) -> NSDictionary {
        return addresses.updateAddress(Int(id)!, datas: datas)
    }
    
    public func removeAddress(id:Int) -> NSDictionary {
        return addresses.removeAddress(id)
    }
    public func removeAddress(id:String) -> NSDictionary {
        return addresses.removeAddress(Int(id)!)
    }
    //---------------------------------------------------------
    public func createUser(datas:[String:String]) -> NSDictionary {
        return users.createUser(datas)
    }
    
    public func updateUser(datas:[String:String], id:Int) -> NSDictionary {
        return users.updateUser(datas,userId: id)
    }
    
    public func logIn(datas:[String:String])  {
        let r = users.logIn(datas)
        
        guard (r["token"] != nil || r["user_id"] != nil) else {
            //print("Critical error \(r)")
            return
        }
        
        self.token = String(r["token"]!)
        self.user_id = Int(String(r["user_id"]!))!
        
        //print( token setted -> \(self.token)")
        //print("user_id setted -> \(self.user_id)")
        
        self.products = Product(key: publicKey, token: token)
        self.categories = Categories(key: publicKey, token: token)
        self.brands = Brands(key: publicKey, token: token)
        self.carts = Carts(key: publicKey, token: token)
        self.addresses = Addresses(key: publicKey, token: token)
        self.users = Users(key: publicKey, token:token)
        self.orders = Orders(key: publicKey, token:token)
        
        //print("ready!")
    }
    
    public func logOut() -> NSDictionary  {
        if(users.logOut()) {
            self.token = ""
            self.user_id = -1
            
            //print("token setted -> \(self.token)")
            //print("user_id setted -> \(self.user_id)")
            
            self.products = Product(key: publicKey)
            self.categories = Categories(key: publicKey)
            self.brands = Brands(key: publicKey)
            self.carts = Carts(key: publicKey)
            self.addresses = Addresses(key: publicKey)
            self.users = Users(key: publicKey)
            self.orders = Orders(key: publicKey)
            //print("logged out!")
            return ["Ok":"Logged Out"]
        } else {
            return ["Error":"unable to logOut. Are you sure you were logged In?"]
        }
    }
    //------------------------------------------------------
    public func createOrder(shippingId:Int, billingId:Int, items:NSArray) -> NSDictionary{
        return orders.createOrder(shippingId, billingId: billingId, items: items)
    }
    
}