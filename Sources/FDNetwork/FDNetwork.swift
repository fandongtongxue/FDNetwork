import Foundation
import Alamofire
import SwiftyJSON
import HandyJSON

public class FDResponseModel: HandyJSON {
    var code : String!
    required init() {}
}

public class FDNetwork : NSObject{
    //class func
    public class func getVersion() -> String {
        return "1.0"
    }
    
    public class func getBuildVersion() -> String {
        return "20200111"
    }
    
    public class func GET(url : String, param : [String : String], className : String, success : @escaping ((FDResponseModel)->()), failure : @escaping ((String)->())) {
        AF.request(url)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                let json = JSON(response.data)
                let modelClass = NSClassFromString(className)
                if let object = modelClass.deserialize(from: json.string) {
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
