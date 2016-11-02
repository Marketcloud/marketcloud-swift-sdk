import Foundation

open class Marketcloud {
    
    open static var version:String = "0.3.3"
    
    fileprivate var publicKey:String
    fileprivate var token:String
    fileprivate var user_id:Int
    
    fileprivate var products:Product
    fileprivate var currencies:Currencies
    fileprivate var categories:Categories
    fileprivate var brands:Brands
    fileprivate var carts:Carts
    fileprivate var addresses:Addresses
    fileprivate var users:Users
    fileprivate var orders:Orders
    fileprivate var shippings:Shippings
    open var utils:Utils
    
    public init(key: String) {
        publicKey = key
        token = ""
        user_id = -1
        
        products = Product(key: publicKey)
        currencies = Currencies(key: publicKey)
        categories = Categories(key: publicKey)
        brands = Brands(key: publicKey)
        carts = Carts(key:publicKey)
        addresses = Addresses(key:publicKey)
        users = Users(key:publicKey)
        shippings = Shippings(key:publicKey)
        
        orders = Orders(key:publicKey)
        utils = Utils()
        //these classes will be reinitialized if an user logs in
    }
    
    open func getKey() -> String {
        return self.publicKey
    }
    open func getUserId() -> Int {
        return self.user_id
    }
    open func getToken() -> String {
        return self.token
    }
    
    //-------------------------------------------------------
    
    open func getProducts() -> NSDictionary {
        return products.getProducts()
    }
    
    open func getProducts(_ filter:[String: Any]) -> NSDictionary {
        return products.getProducts(filter)
    }
    
    open func getProductById(_ id:Int) -> NSDictionary {
        return products.getProductById(id)
    }
    open func getProductById(_ id:String) -> NSDictionary {
        return products.getProductById(Int(id)!)
    }
    
    open func getProductsByCategory(_ id:Int) -> NSDictionary {
        return products.getProductsByCategory(id)
    }
    open func getProductsByCategory(_ id:String) -> NSDictionary {
        return products.getProductsByCategory(Int(id)!)
    }
    
    //-------------------------------------------------------
    
    open func getCategories() -> NSDictionary {
        return categories.getCategories()
    }
    
    open func getCategoryById(_ id:Int) -> NSDictionary {
        return categories.getCategoryById(id)
    }
    open func getCategoryById(_ id:String) -> NSDictionary {
        return categories.getCategoryById(Int(id)!)
    }
    //-------------------------------------------------------
    
    open func getBrands() -> NSDictionary {
        return brands.getBrands()
    }
    
    open func getBrandById(_ id:Int) -> NSDictionary {
        return brands.getBrandById(id)
    }
    open func getBrandById(_ id:String) -> NSDictionary {
        return brands.getBrandById(Int(id)!)
    }
    //-------------------------------------------------------
    
    open func createEmptyCart() -> NSDictionary {
        return carts.createEmptyCart()
    }
    
    open func getCart() -> NSDictionary {
        return carts.getCart()
    }
    open func getCart(_ id:Int) -> NSDictionary {
        return carts.getCart(id)
    }
    open func getCart(_ id:String) -> NSDictionary {
        return carts.getCart(Int(id)!)
    }
    
    open func addToCart(_ id:Int, data:[Any]) -> NSDictionary {
        return carts.addToCart(id, data:data)
    }
    open func addToCart(_ id:String, data:[Any]) -> NSDictionary {
        return carts.addToCart(Int(id)!, data:data)
    }
    
    open func updateCart(_ id:Int, data:[Any]) -> NSDictionary {
        return carts.updateCart(id, data:data)
    }
    open func updateCart(_ id:String, data:[Any]) -> NSDictionary {
        return carts.updateCart(Int(id)!, data:data)
    }
    
    open func removeFromCart(_ id:Int, data:[Any]) -> NSDictionary {
        return carts.removeFromCart(id, data:data)
    }
    open func removeFromCart(_ id:String, data:[Any]) -> NSDictionary {
        return carts.removeFromCart(Int(id)!, data:data)
    }
    
    //---------------------------------------------------------
    
    open func createAddress(_ datas:[String:Any]) -> NSDictionary {
        return addresses.createAddress(datas)
    }
    
    open func getAddresses() -> NSDictionary {
        return addresses.getAddresses()
    }
    
    open func getAddress(_ id:Int) -> NSDictionary {
        return addresses.getAddress(id)
    }
    open func getAddress(_ id:String) -> NSDictionary {
        return addresses.getAddress(Int(id)!)
    }
    
    open func updateAddress(_ id:Int, datas:[String:Any]) -> NSDictionary {
        return addresses.updateAddress(id, datas: datas)
    }
    open func updateAddress(_ id:String, datas:[String:Any]) -> NSDictionary {
        return addresses.updateAddress(Int(id)!, datas: datas)
    }
    
    open func removeAddress(_ id:Int) -> NSDictionary {
        return addresses.removeAddress(id)
    }
    open func removeAddress(_ id:String) -> NSDictionary {
        return addresses.removeAddress(Int(id)!)
    }
    
    //---------------------------------------------------------
    
    open func createUser(_ datas:[String:String]) -> NSDictionary {
        return users.createUser(datas)
    }
    
    open func updateUser(_ datas:[String:String], id:Int) -> NSDictionary {
        return users.updateUser(datas,userId: id)
    }
    
    open func logIn(_ datas:[String:String]) -> NSDictionary  {
        let r:NSDictionary = users.logIn(datas)
        
        guard (r["token"] != nil || r["user_id"] != nil) else {
            //something went wrong...
            return r
        }
        
        self.token = String(describing: r["token"]!)
        self.user_id = Int(String(describing: r["user_id"]!))!
        
        //print("token setted -> \(self.token)")
        //print("user_id setted -> \(self.user_id)")
        
        self.products = Product(key: publicKey, token: token)
        self.currencies = Currencies(key: publicKey, token: token)
        self.categories = Categories(key: publicKey, token: token)
        self.brands = Brands(key: publicKey, token: token)
        self.carts = Carts(key: publicKey, token: token)
        self.addresses = Addresses(key: publicKey, token: token)
        self.users = Users(key: publicKey, token:token)
        self.orders = Orders(key: publicKey, token:token)
        self.shippings = Shippings(key: publicKey, token:token)
        
        
        //print("ready!")
        return ["Ok":"Logged In"]
    }
    
    open func logOut() -> NSDictionary  {
        if(users.logOut()) {
            self.token = ""
            self.user_id = -1
            
            //print("token setted -> \(self.token)")
            //print("user_id setted -> \(self.user_id)")
            
            self.products = Product(key: publicKey)
            self.currencies = Currencies(key: publicKey)
            self.categories = Categories(key: publicKey)
            self.brands = Brands(key: publicKey)
            self.carts = Carts(key: publicKey)
            self.addresses = Addresses(key: publicKey)
            self.users = Users(key: publicKey)
            self.orders = Orders(key: publicKey)
            self.shippings = Shippings(key: publicKey)
            
            //print("logged out!")
            return ["Ok":"Logged Out"]
        } else {
            return ["Error":"unable to logOut. Are you sure you were logged In?"]
        }
    }
    //------------------------------------------------------
    
    open func createOrder(_ shippingId:Int, billingId:Int, cartId:Int) -> NSDictionary{
        return orders.createOrder(shippingId, billingId: billingId, cart_id: cartId)
    }
    open func createOrder(_ shippingId:String, billingId:String, cartId:String) -> NSDictionary{
        return orders.createOrder(Int(shippingId)!, billingId: Int(billingId)!, cart_id: Int(cartId)!)
    }
    
    
    open func completeOrder(_ orderId:Int, stripeToken:String) -> NSDictionary {
        return orders.completeOrder(orderId, stripeToken: stripeToken)
    }
    open func completeOrder(_ orderId:String, stripeToken:String) -> NSDictionary {
        return orders.completeOrder(Int(orderId)!, stripeToken: stripeToken)
    }
    //------------------------------------------------------
    
    open func getCurrencies() -> NSDictionary {
        return currencies.getCurrencies()
    }
    //------------------------------------------------------
    
    open func getShippings() -> NSDictionary {
        return shippings.getShippings()
    }
    open func getShippingById(_ id:Int) -> NSDictionary {
        return shippings.getShippingById(id)
    }
    open func getShippingById(_ id:String) -> NSDictionary {
        return shippings.getShippingById(Int(id)!)
    }
}
