# marketcloud-swift-sdk
#####The official repository for Marketcloud iOS swift SDK (beta)

Marketcloud is a mobile-first e-commerce backend as a service. If you wish to use this SDK in order to build your own Android application, you have to subscribe to Marketcloud's program (actually in beta).

[![Marketcloud](https://media.licdn.com/media/AAEAAQAAAAAAAARfAAAAJDg0NDI5OTU2LWQ2MDQtNGU4YS1iMzQwLTNkY2VjYTBjM2FjYw.png)](http://www.marketcloud.it/)[![Swift](http://mkdutton.com/img/swift_icon.png)](https://developer.apple.com/swift/)

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

___________________________________________________________________________________________________________________________

#Setup

### Installation via Carthage

######Just follow these steps:

1) Install the last release of Carthage.pkg (https://github.com/Carthage/Carthage/releases)

2) Create your new Xcode project

3) Open the terminal, navigate to the root directory of your project (the directory that contains your .xcodeproj file)

4) Create an empty Cartfile with the touch command: ```touch Cartfile```

5) open the file up in Xcode for editing (don't close your terminal!): ```open -a Xcode Cartfile```

6) You will see an empty page. Just write ```github "Marketcloud/marketcloud-swift-sdk"``` and close it.

7) Return on your terminal and write ```carthage update --platform iOS``` or simply ```carthage update```
    
8) Carthage will clone the repository and create a new .framework file for you. Just wait for a bit and when the operation is over close your terminal, open Xcode and your project and follow the last step of this tutorial..

9) Select your project in the Project Navigator. Select the <YOUR PROJECT> target, choose the General tab at the top, and scroll down to the Linked Frameworks and Libraries section at the bottom. Open a Finder window and navigate to         the <YOUR PROJECT>Folder, then go to the Carthage -> Build -> iOS folder (you should be in a similar situation:            <YOUR PROJECT>/Carthage/Build/iOS Now, drag Marketcloud.framework into the Linked Frameworks and Libraries section          in Xcode.

Confused? Click here for a .gif with with a similar situation
<http://cdn2.raywenderlich.com/wp-content/uploads/2015/06/carthage-settings.gif>

10) Last (but not least...) On your application targets “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following contents:
    /usr/local/bin/carthage copy-frameworks
    and add the paths to the frameworks you want to use under “Input Files”, e.g.:

    $(SRCROOT)/Carthage/Build/iOS/Marketcloud.framework

This script works around an App Store submission bug triggered by universal binaries and ensures that necessary bitcode-related files and dSYMs are copied when archiving.

If you are *still* confused or this tutorial is not good enough for you, check this [Carthage tutorial](http://www.raywenderlich.com/109330/carthage-tutorial-getting-started) or the official [Carthage Github page](https://github.com/Carthage/Carthage)

and... if you want more, [Check this out!](http://www.mokacoding.com/blog/setting-up-testing-libraries-with-carthage-xcode7/) (this last is the best in my opinion)
______________________________________________________________________________________________________________________________________

#THE SDK

Here you can find all the methods explained and a tutorial about how to work with the sdk

Are you in a hurry? Or maybe you just want to try yourself? Here's a playground with every method available to be tested -> [download me!](https://www.dropbox.com/s/7djiiwsnx20a0kt/Marketcloud_Playground.playground.rar?dl=0 "Marketcloud's Playground")

If you managed to import the library via Carthage you could import the SDK with  ```import Marketcloud ```

Then istantiate a Marketcloud object with ```var marketcloud = Marketcloud(key: "insert_your_public_key_here");```

And.... you are good to go!

## Products


```marketcloud.getProducts() ``` returns a NSDictionary with all the products in your store

```marketcloud.getProducts(filter:[String: AnyObject]) ```
Use this method to filter the products.

Example:

```
var itemArray = [String: AnyObject]()
itemArray.append(["Author":"Tolkien","Pages":"213"])

marketcloud.getProducts(itemArray)

```
returns a NSDictionary with all the products that match with the filters.


```marketcloud.getProductById(id:Int) ``` returns a NSDictionary with the informations about the product with that Id
```marketcloud.getProductById(id:String) ``` same as before, but you can insert the Id as a String instead of an Integer

```marketcloud.getProductsByCategory(id:Int) ``` returns a NSDictionary with the informations about all the products belonging to that category
```marketcloud.getProductsByCategory(id:String) ``` same as before, but you can insert the Id as a String instead of an Integer

## Categories

```marketcloud.getCategories() ``` returns a NSDictionary with all the categories in your store

```marketcloud.getCategoryById(id:Int) ``` returns a NSDictionary with the informations about the category with that Id
```marketcloud.getCategoryById(id:String) ``` same as before, but you can insert the Id as a String instead of an Integer

## Brands

```marketcloud.getBrands() ``` returns a NSDictionary with all the brands in your store

```marketcloud.getBrandById(id:Int) ``` returns a NSDictionary with the informations about the brand with that Id
```marketcloud.getBrandById(id:String) ``` same as before, but you can insert the Id as a String instead of an Integer

## Carts

```marketcloud.createEmptyCart() ``` creates a new cart and returns a NSDictionary with the informations about the new cart

```marketcloud.getCart() ``` !!!**_ONLY FOR LOGGED USERS_**!!! Returns a NSDictionary with the informations about the user's cart

```marketcloud.getCart(id:Int) ``` Returns a NSDictionary with the informations about the cart with that Id
```marketcloud.getCart(id:String) ``` same as before, but you can insert the Id as a String instead of an Integer

```marketcloud.addToCart(id:Int, data:[AnyObject]) ```  'id' is the cart's id, data:[AnyObject] is an array with informations about the products Id and the quantity of the selected products

Example:

```
var itemArray = [AnyObject]()
itemArray.append(["product_id":8762,"quantity":2])
itemArray.append(["product_id":8766,"quantity":3])

marketcloud.addToCart(idCart, data: itemArray)
```

A NSDictionary with the infos about the updated cart will be returned.


```marketcloud.addToCart(id:String, data:[AnyObject]) ```  Same as before, but you can insert the Id as a String instead of an Integer

```marketcloud.updateCart(id:Int, data:[AnyObject]) ```  This method is similar to the 'addToCart' one. Its purpose is to insert a 'data' array with informations about a product that still exists in the cart and to update its quantity value.
If the products didn't exist, it will be added (exactly like calling the 'addToCart' method). 
A NSDictionary with the infos about the updated cart will be returned.
```marketcloud.updateCart(id:String, data:[AnyObject]) ```  Same as before, but you can insert the Id as a String instead of an Integer

```marketcloud.removeFromCart(id:Int, data:[AnyObject]) ```  This method needs the id of the cart and an array with the informations about the id of the product(s) you want to remove from the cart.

Example:

```
var itemArray = [AnyObject]()
itemArray.append(["product_id":8762])
itemArray.append(["product_id":8766])

marketcloud.removeFromCart(idCart, data: itemArray)
```

Note that if the product is not in the cart, nothing will happen.

```marketcloud.removeFromCart(id:String, data:[AnyObject]) ```  Same as before, but you can insert the Id as a String instead of an Integer.


## Addresses

```marketcloud.createAddress(datas:[String:AnyObject]) ```  Creates a new address and returns a NSDictionary with the informations about the created address.

example:

```
let testAddress:[String:String] = ["email":"fakeEmail@email.it","full_name": "alienFromOuterSpace","country" : "universe", "state": "LmaoLand", "city": "lmaoTown", "address1": "ayyy, 1", "postal_code": "123", "address2":"Lmao"]

marketcloud.createAddress(testAddress)
```

Accepted fields:

- email [required]
- full_name [required]
- country [required]
- state [required]
- city [required]
- address1 [required]
- postal_code [required]
- address2 
- phone_number
- alternate_phone_number


```marketcloud.getAddresses() ``` !!!**_ONLY FOR LOGGED USERS_**!!! Returns a NSDictionary with the informations about the user's addresses

```marketcloud.getAddress(id:Int) ``` Returns a NSDictionary with the informations about the address
```marketcloud.getAddress(id:String) ``` Same, but you can insert a String instead of an Integer

```marketcloud.updateAddress(id:Int, datas:[String:AnyObject]) ``` updates an address given its Id. Accepts an array in the same way as the createAddress one. Returns an NSDictionary with the information about the updated address
```marketcloud.updateAddress(id:String, datas:[String:AnyObject]) ``` Same, but you can insert a String instead of an Integer

```marketcloud.removeAddress(id:Int) ``` removes an address given its Id
```marketcloud.removeAddress(id:String) ``` Same, but you can insert a String instead of an Integer

## Users

```marketcloud.createUser(datas:[String:AnyObject]) ``` Creates a new User. Accepts an array with the informations about the user.
```marketcloud.updateUser(datas:[String:AnyObject], id:Int) ``` Updates an existing User. Accepts an array with the informations about the user and the id of the user.

Example:

```
let testAddress:[String:String] = ["email":"fakemail3@lmao.it","name": "alienFromOuterSpace","password" : "universe"]
marketcloud.createUser(testAddress);
```   

Accepted fields:

- email [required]
- name [required]
- password [required]

Returns a NSDictionary with informations about the created user.

```marketcloud.logIn(datas:[String:AnyObject]) ``` Use this method to perform a login for the current user.

Example:

```
let loginTest:[String:String] = ["email":"fakemail3@lmao.it", "password":"universe"]
marketcloud.logIn(loginTest)
```   

Accepted fields:

- email [required]
- password [required]

Returns a NSDictionary with informations about the user.

After a successful login, headers will automatically change and all the operations from this point on will be performed as a logged user (es getCart(), getAddresses()).
_If you want to return to the 'non-logged' state you must use the logOut() method or re-initialize  the marketcloud object._
d
```marketcloud.logOut() ``` logs out the current user (if logged in). Returns a NSDictionary with informations about the operation.

## ORDERS

```marketcloud.createOrder(shippingId:Int, billingId:Int, items:NSArray) ``` confirms an order. This method needs a shipping and a billing address Id and an array with the items in the current cart.

Example
```
//retrieving the items in the cart
let r  = (marketcloud.getCart()["data"]!["items"]!!) as! NSArray

//suppose that '13320' is a valid address Id
marketcloud.createOrder(13320, billingId: 13320, items: r)
//Note that the shipping and the billing address Ids could be different!
```
Returns a NSDictionary with informations about the order.

```marketcloud.completeOrder(orderId:Int, stripeToken:String) ``` . 
This method completes an order and needs  the order's id and a valid Stripe Token.
Call it after createOrder() and when you have a valid Stripe Token (using Stripe's SDK).

Returns a NSDictionary with informations about the order.

##Currencies
```marketcloud.getCurrencies() ```

Returns a NSDictionary with informations about the actual currencies.

##Utils
There are some useful methods that could help you in using the SDK.


 ```marketcloud.utils.checkVarType(myVar:AnyObject?) ``` prints information about the variable type
 ```marketcloud.utils.stringBuilder(myVar:NSDictionary) ``` converts a NSDictionary into a NSString
 ```marketcloud.utils.isValidJson(jsonObject:AnyObject) ``` returns true if the object is a valid Json
 ```marketcloud.utils.timeStamp() ``` returns an UInt with the current timestamp

##Other

```marketcloud.getKey() ``` returns the actual publicKey
```marketcloud.userId() ``` returns the actual user Id (-1 if user is not logged in)
```marketcloud.userId() ``` returns the actual user token (returns an empty string if user is not logged in)
______________________________________________________________________________________________________________________________________

##PLAYGROUND

I _strongly_ recommend to check the [SDK's Playground](https://www.dropbox.com/s/7djiiwsnx20a0kt/Marketcloud_Playground.playground.rar?dl=0 "Marketcloud SDK's Playground").
There are almost all methods explained, and you can test them in real time (there is a key with a sample store for testing purposes).

___________________________________________________________________________________________________________________________
##Sample application

[Sample Swifth application using the SDK](https://github.com/Marketcloud/marketcloud-swift-application "Sample Swifth application using the SDK")
___________________________________________________________________________________________________________________________
## HTTPS##
This SDK uses HTTPS for every communication with the API!
___________________________________________________________________________________________________________________________

##LICENCE

Copyright 2015 [Marketcloud](http://www.marketcloud.it/)

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License (see 'LICENCE.md' in the main project's directory).

___________________________________________________________________________________________________________________________

###Additional

- special thanks to [JUST](https://github.com/JustHTTP/Just) for the amazing HTTP library!
- special thanks to [Reachability.swift](https://github.com/ashleymills/Reachability.swift)
