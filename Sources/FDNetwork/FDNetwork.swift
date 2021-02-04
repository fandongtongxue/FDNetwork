import Foundation
import Alamofire
import SwiftyJSON

public class FDNetwork : NSObject{
    
    //class func
    public class func getVersion() -> String {
        return "1.0"
    }
    
    public class func getBuildVersion() -> String {
        return "20200903"
    }
    
    
    /// GET Function
    /// - Parameters:
    ///   - url: url
    ///   - param: param
    ///   - success: successCallBack
    ///   - failure: failureCallBack
    public class func GET(url : String, param : [String : String]?, success : @escaping (([String : Any])->()), failure : @escaping ((String)->())) {
        AF.request(url, method: .get, parameters: param, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil)
        .responseData { response in
            switch response.result {
            case .success:
                let json = JSON(response.data ?? Data.init())
                if (json.dictionaryObject != nil) {
                    if (json.dictionaryObject?.values.count)! > 0{
                        success(json.dictionaryObject!)
                    }else{
                        failure(NSLocalizedString("Network.RequestFailed", comment: ""))
                    }
                }else{
                    failure(NSLocalizedString("Network.RequestFailed", comment: ""))
                }
            case let .failure(error):
                failure(error.localizedDescription)
            }
        }
    }
    
    
    /// POST Function
    /// - Parameters:
    ///   - url: url
    ///   - param: param
    ///   - success: successCallBack
    ///   - failure: failureCallBack
    public class func POST(url : String, param : [String : String]?, success : @escaping (([String : Any])->()), failure : @escaping ((String)->())) {
        AF.request(url, method: .post, parameters: param, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil)
        .responseData { response in
            switch response.result {
            case .success:
                let json = JSON(response.data ?? Data.init())
                if (json.dictionaryObject != nil) {
                    if (json.dictionaryObject?.values.count)! > 0{
                        success(json.dictionaryObject!)
                    }else{
                        failure(NSLocalizedString("Network.RequestFailed", comment: ""))
                    }
                }else{
                    failure(NSLocalizedString("Network.RequestFailed", comment: ""))
                }
            case let .failure(error):
                failure(error.localizedDescription)
            }
        }
    }
    
    static let manager = FDNetwork()

    private class func defaultManager() ->FDNetwork {
        return manager
    }
}
