//
//  FYNetApi.swift
//  qhm
//
//  Created by wang on 2019/4/11.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit
import Moya

public enum FYAPI {
    case homeList //首页列表
}
extension FYAPI :TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .homeList:
            return URL(string: "http://47.104.79.197:8080")!
        }
        
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .homeList:
            return "/newsapi/Server/microText/listMicroText.do"
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        switch self {
        case .homeList:
            return .post
        }
    }
    
    //请求任务事件（这里附带上参数),想想如果接口多的话,这里会是多么壮观
    public var task: Task {
        let params: [String: Any] = [:]
        switch self {
        case .homeList:
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        }
    }
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    //请求头
    public var headers: [String : String]? {
        return nil
    }
}

// MARK: - 默认的网络提示请求插件
let spinerPlugin = NetworkActivityPlugin { (state,target) in
    if state == .began {
        print("我开始请求")
//        MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
    } else {
        print("我结束请求")
//        MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
    }
}

// MARK: - 设置请求超时时间
let requestClosure = {(endpoint: Endpoint, done: @escaping MoyaProvider<FYAPI>.RequestResultClosure) in
    do {
        var request: URLRequest = try endpoint.urlRequest()
        request.timeoutInterval = 20    //设置请求超时时间
        done(.success(request))
    } catch  {
        print("错误了 \(error)")
    }
}

// MARK: - 设置请求头部信息
var endpointClosure = { (target: FYAPI) -> Endpoint in
    let sessionId =  ""
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    var endpoint: Endpoint = Endpoint(
        url: url,
        sampleResponseClosure: {.networkResponse(200, target.sampleData)},
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
    )
    return endpoint.adding(newHTTPHeaderFields: [
        "Content-Type" : "application/x-www-form-urlencoded",
        "COOKIE" : "JSESSIONID=\(sessionId)",
        "Accept": "application/json;application/octet-stream;text/html,text/json;text/plain;text/javascript;text/xml;application/x-www-form-urlencoded;image/png;image/jpeg;image/jpg;image/gif;image/bmp;image/*"
        ])
    
}

class FYNetApi: NSObject {

}
