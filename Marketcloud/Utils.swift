import Foundation

public class Utils {
    
    public init(){}
    
    public func checkVarType(myVar:AnyObject?) {
        guard myVar != nil else {
            print("variable type : NIL")
            return
        }
        print("variable type : \(Mirror(reflecting: myVar!))")
    }
    
    public func stringBuilder(myDictOfDict:NSDictionary) -> String {
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(myDictOfDict, options: [])
            return NSString(data: data, encoding: NSUTF8StringEncoding) as! String
        } catch {
            return "STRINGBUILDER_ERROR"
        }
    }
    
    public func isValidJson(jsonObject:AnyObject) -> Bool {
        return NSJSONSerialization.isValidJSONObject(jsonObject)
    }
    
    public func timeStamp() -> UInt {
        return UInt(NSDate().timeIntervalSince1970*1000)
    }
    
    public func getVersion() -> String {
        return Marketcloud.version
    }
}