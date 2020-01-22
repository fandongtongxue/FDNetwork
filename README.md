# FDNetwork
网络工具
## 引入
Package.swift中添加dependency
```
dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/fandongtongxue/FDNetwork.git", from: "master"),
    ],
```
## 使用
### GET/POST
```
/// GET Function
/// - Parameters:
///   - url: url
///   - param: param
///   - success: successCallBack
///   - failure: failureCallBack
public class func GET(url: String, param: [String : String]?, success: @escaping (([String : Any]) -> ()), failure: @escaping ((String) -> ()))
```
```
/// POST Function
/// - Parameters:
///   - url: url
///   - param: param
///   - success: successCallBack
///   - failure: failureCallBack
public class func POST(url: String, param: [String : String]?, success: @escaping (([String : Any]) -> ()), failure: @escaping ((String) -> ()))
```
### Download
```
// Download Function
/// - Parameters:
///   - url: url
///   - path: path
///   - param: param
///   - progress: progressCallBack
///   - success: successCallBack
///   - failure: failureCallBack
public class func DOWNLOAD(url: String, path: String, param: [String : String]?, progress: @escaping ((Double) -> ()), success: @escaping ((String) -> ()), failure: @escaping ((String) -> ()))
```
