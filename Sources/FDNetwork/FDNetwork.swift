import Foundation
import Alamofire
import SwiftyJSON
import FDCommon
import Tiercel

public class FDNetwork : NSObject{
    
    //class func
    public class func getVersion() -> String {
        return "1.1"
    }
    
    public class func getBuildVersion() -> String {
        return "20200121"
    }
    
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
    
    public class func DOWNLOAD(url : String, path : String, param : [String : String]?, progress : @escaping ((Float)->()), success : @escaping ((String)->()), failure : @escaping ((String)->())) {
        let config = SessionConfiguration.init()
        let sessionManager = SessionManager.init(url, configuration: config)
        let task = sessionManager.download(url)
    }
}
