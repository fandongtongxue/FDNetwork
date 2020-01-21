import Foundation
import Alamofire
import SwiftyJSON
import HandyJSON

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
                if (json.dictionaryObject?.values.count)! > 0{
                    success(json.dictionaryObject!)
                }else{
                    failure("数据为空")
                }
            case let .failure(error):
                failure(error.localizedDescription)
            }
        }
    }

}
