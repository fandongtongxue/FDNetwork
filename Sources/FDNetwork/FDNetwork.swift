import Foundation
import Alamofire
import SwiftyJSON
import Tiercel

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
    
    private var downloadManager: SessionManager = {
        var configuration = SessionConfiguration()
        configuration.allowsCellularAccess = true
        let manager = SessionManager("default", configuration: configuration)
        return manager
    }()
    
    /// Download Function
    /// - Parameters:
    ///   - url: url
    ///   - path: path
    ///   - param: param
    ///   - progress: progressCallBack
    ///   - success: successCallBack
    ///   - failure: failureCallBack
    public class func DOWNLOAD(url : String, path : String, progress : @escaping ((Double)->()), success : @escaping ((String)->()), failure : @escaping ((String)->())) {
        let task = FDNetwork.defaultManager().downloadManager.download(url)
        task?.progress(onMainQueue: true) { (task) in
            let percennt = task.progress.fractionCompleted
            progress(percennt)
        }
        .completion {(manager) in
            if manager.status == .succeeded {
                success("Download Success")
                let fileManager = FileManager.default
                do{
                    try fileManager.moveItem(atPath: task!.filePath, toPath: path);
                    print("Succsee to move file.")
                }catch{
                    print("Failed to move file.")
                }
            } else {
                failure("DownLoad Failure:\(manager.status)")
            }
        }
    }
}
