import Foundation
import Alamofire
import SwiftyJSON
import HandyJSON

open class FDResponseModel: HandyJSON {
    required public init() {}
}

public class FDNetwork : NSObject{
    
    //class func
    public class func getVersion() -> String {
        return "1.1"
    }
    
    public class func getBuildVersion() -> String {
        return "20200115"
    }
    
    public class func GET(url : String, param : [String : String]?, className : String, success : @escaping ((FDResponseModel)->()), failure : @escaping ((String)->())) {
        AF.request(url, method: .get, parameters: param, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil)
        .responseData { response in
            switch response.result {
            case .success:
                let json = JSON(response.data)
                let classT = NSClassFromString(className) as! FDResponseModel.Type
                if let object = classT.deserialize(from: json.string) {
                    success(object)
                }else{
                    failure("解析模型失败")
                }
            case let .failure(error):
                failure(error.localizedDescription)
            }
        }
    }

}
