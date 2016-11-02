import Foundation

open class Utils {
    
    public init(){}
    
    open func checkVarType(_ myVar:Any?) {
        guard myVar != nil else {
            print("variable type : NIL")
            return
        }
        print("variable type : \(Mirror(reflecting: myVar!))")
    }
    
    open func stringBuilder(_ myDictOfDict:NSDictionary) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: myDictOfDict, options: [])
            return NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
        } catch {
            return "STRINGBUILDER_ERROR"
        }
    }
    
    open func isValidJson(_ jsonObject:Any) -> Bool {
        return JSONSerialization.isValidJSONObject(jsonObject)
    }
    
    open func timeStamp() -> UInt {
        return UInt(Date().timeIntervalSince1970*1000)
    }
    
    open func getVersion() -> String {
        return Marketcloud.version
    }
}

extension Dictionary {
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        return parameterArray.joined(separator: "&")
    }
}

extension String {
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    ///
    /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Returns percent-escaped string.
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
}
