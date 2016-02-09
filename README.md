# marketcloud-swift-sdk
The official repository for Marketcloud iOS swift SDK (beta)

[![Marketcloud](https://media.licdn.com/media/AAEAAQAAAAAAAARfAAAAJDg0NDI5OTU2LWQ2MDQtNGU4YS1iMzQwLTNkY2VjYTBjM2FjYw.png)](http://www.marketcloud.it/)[![Swift](http://mkdutton.com/img/swift_icon.png)](https://developer.apple.com/swift/)

Added Carthage support!

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

In order to include this framework on your project you must follow these steps:

1) Install the last release of Carthage.pkg (https://github.com/Carthage/Carthage/releases)

2) Create your new Xcode project

3) Open the terminal, navigate to the root directory of your project (the directory that contains your .xcodeproj file)

4) Create an empty Cartfile with the touch command: ```touch Cartfile```

5) open the file up in Xcode for editing (don't close your terminal!): ```open -a Xcode Cartfile```

6) You will see an empty page. Just write ```github "Marketcloud/marketcloud-swift-sdk"``` and close it.

7) Return on your terminal and write ```carthage update --platform iOS``` or simply ```carthage update```

8) Carthage will clone the repository and create a new .framework file for you.
Just wait for a bit and when the operation is over close your terminal, open Xcode and your project and follow the last step of this tutorial..

9) Select your project in the Project Navigator. Select the <YOUR PROJECT> target, choose the General tab at the top, and scroll down to the Linked Frameworks and Libraries section at the bottom.
Open a Finder window and navigate to the <YOUR PROJECT>Folder, then go to the Carthage -> Build -> iOS folder (you should be in a similar situation: <YOUR PROJECT>/Carthage/Build/iOS
Now, drag MarketcloudSDK.framework into the Linked Frameworks and Libraries section in Xcode.

Confused? Click here for a .gif with with a similar situation
<http://cdn2.raywenderlich.com/wp-content/uploads/2015/06/carthage-settings.gif>

..But if you are *still* confused or maybe this tutorial is not so good , check this other  (and better) Carthage tutorial here!
<http://www.raywenderlich.com/109330/carthage-tutorial-getting-started>


Now create some Swift files and add an  ```import Marketcloud ```

Then istantiate a MarketcloudSDK object with ```var marketcloudObject = MarketCloud(key: "123123");```

And you are good to go!
 

..To be continued 

