import Foundation
import Alamofire
import SwiftyJSON
import UIKit

public class FDNetwork : NSObject{
    
    //class func
    public class func getVersion() -> String {
        return "2.0"
    }
    
    public class func getBuildVersion() -> String {
        return "20221206"
    }
    
    public class func GET(url: String, param: Parameters? = nil, success: @escaping ((Any)->()), failure: @escaping ((String)->())) {
        FDNetwork.HTTP(method: .get, url: url, header: nil, param: param, success: success, failure: failure)
    }
    
    public class func POST(url: String, param: Parameters? = nil, success: @escaping ((Any)->()), failure: @escaping ((String)->())) {
        FDNetwork.HTTP(method: .post, url: url, header: nil, param: param, success: success, failure: failure)
    }
    
    public class func PUT(url: String, param: Parameters? = nil, success : @escaping ((Any)->()), failure: @escaping ((String)->())) {
        FDNetwork.HTTP(method: .put, url: url, header: nil, param: param, success: success, failure: failure)
    }
    
    public class func DELETE(url: String, param: Parameters? = nil, success: @escaping ((Any)->()), failure: @escaping ((String)->())) {
        FDNetwork.HTTP(method: .delete, url: url, header: nil, param: param, success: success, failure: failure)
    }
    
    public class func PATCH(url: String, param: Parameters? = nil, success: @escaping ((Any)->()), failure: @escaping ((String)->())) {
        FDNetwork.HTTP(method: .patch, url: url, header: nil, param: param, success: success, failure: failure)
    }

    public class func GET(url: String, header: [String : String]?, param: Parameters? = nil, success: @escaping ((Any)->()), failure: @escaping ((String)->())) {
        FDNetwork.HTTP(method: .get, url: url, header: header, param: param, success: success, failure: failure)
    }
    
    public class func POST(url: String, header: [String : String]?, param: Parameters? = nil, success: @escaping ((Any)->()), failure: @escaping ((String)->())) {
        FDNetwork.HTTP(method: .post, url: url, header: header, param: param, success: success, failure: failure)
    }
    
    public class func PUT(url: String, header: [String : String]?, param: Parameters? = nil, success: @escaping ((Any)->()), failure: @escaping ((String)->())) {
        FDNetwork.HTTP(method: .put, url: url, header: header, param: param, success: success, failure: failure)
    }
    
    public class func DELETE(url: String, header: [String : String]?, param: Parameters? = nil, success: @escaping ((Any)->()), failure: @escaping ((String)->())) {
        FDNetwork.HTTP(method: .delete, url: url, header: header, param: param, success: success, failure: failure)
    }
    
    public class func PATCH(url: String, header: [String : String]?, param : Parameters? = nil, success: @escaping ((Any)->()), failure: @escaping ((String)->())) {
        FDNetwork.HTTP(method: .patch, url: url, header: header, param: param, success: success, failure: failure)
    }
    
    public class func HTTP(method: HTTPMethod, url: String, header: [String : String]?, param: Parameters? = nil, success: @escaping ((Any)->()), failure: @escaping ((String)->())) {
        let httpHeader = HTTPHeaders.init(header ?? [:])
        let encodeURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        AF.request(encodeURL, method: method, parameters: param, encoding: JSONEncoding.default, headers: httpHeader)
            .responseData { response in
                switch response.result {
                case .success:
                    if response.data != nil {
                        let json = JSON(response.data ?? Data())
                        if (json.dictionaryObject != nil) {
                            success(json.dictionaryObject!)
                        }else if (json.arrayObject != nil){
                            success(json.arrayObject!)
                        }else{
                            if url.contains("chelaile") {
                                var string = String(data: response.data!, encoding: .utf8)!
                                for _ in 0..<6 {
                                    string.removeFirst()
                                }
                                for _ in 0..<6 {
                                    string.removeLast()
                                }
                                let newJson = JSON(string.data(using: .utf8) ?? Data())
                                if (newJson.dictionaryObject != nil) {
                                    success(newJson.dictionaryObject!)
                                }else if (newJson.arrayObject != nil){
                                    success(newJson.arrayObject!)
                                }else{
                                    failure(NSLocalizedString("Network.RequestFailed", comment: ""))
                                }
                            }else{
                                failure(NSLocalizedString("Network.RequestFailed", comment: ""))
                            }
                        }
                    }else{
                        success(["message":"success"])
                    }
                case let .failure(error):
                    failure(error.localizedDescription)
                }
            }
    }
    
    public class func UPLOAD(url : String, image: UIImage, param: [String : String]?, progressHandler: @escaping ((Float)->()), success: @escaping (([String : Any])->()), failure: @escaping ((String)->())) {
        FDNetwork.UPLOAD(url: url, image: image, header: [:], param: param, progressHandler: progressHandler, success: success, failure: failure)
    }
    
    public class func UPLOAD(url : String, image: UIImage, header: [String : String]?, param: [String : String]?, progressHandler: @escaping ((Float)->()), success: @escaping (([String : Any])->()), failure: @escaping ((String)->())) {
        let httpHeader = HTTPHeaders.init(header ?? [:])
        let timestamp = floor(Date().timeIntervalSince1970)
        let request = AF.upload(multipartFormData: { data in
            data.append(image.jpegData(compressionQuality: 1)!, withName: "smfile", fileName: "smfile"+"\(timestamp)"+".jpg", mimeType: "image/jpeg")
        }, to: URL(string: url)!, headers: httpHeader)
        request.response { response in
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
        request.uploadProgress { progress in
            progressHandler(Float(progress.completedUnitCount)/Float(progress.totalUnitCount))
        }
    }
}
