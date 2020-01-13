import Foundation
import Alamofire

public class FDNetwork : NSObject{
    //class func
    public class func getVersion() -> String {
        return "1.0"
    }
    
    public class func getBuildVersion() -> String {
        return "20200111"
    }
    
    public class func GET(url : String, param : [String : Any]) {
        AF.request(url,
                   method: .get,
                   parameters: param,
                   encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
        }
    }
    
    
    
}
