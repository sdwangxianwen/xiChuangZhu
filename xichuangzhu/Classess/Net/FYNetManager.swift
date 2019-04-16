//
//  FYNetManager.swift
//  qhm
//
//  Created by wang on 2019/4/11.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

//成功的闭包
typealias SuccessJSONClosure = (_ result:JSON) -> Void  //返回的是json
//失败的闭包
typealias FailClosure = (_ result : String?) -> Void

class FYNetManager: NSObject {
    static let shared = FYNetManager()
    
    private override init(){}
    private let failInfo = "数据解析失败"
    
    /// 请求JSON数据
    func requestDataWithTargetJSON(target : FYAPI, successClosure: @escaping SuccessJSONClosure, failClosure: @escaping FailClosure) {
        let requestProvider = MoyaProvider<FYAPI>(endpointClosure: endpointClosure, requestClosure : requestClosure,plugins:[spinerPlugin])
        let _ = requestProvider.request(target) { (result) -> () in
            switch result{
            case let .success(response):
                do {
                    let mapjson = try response.mapJSON()
                    let json = JSON(mapjson)
                    guard let _ = json.dictionaryObject else{
                        failClosure(self.failInfo)
                        return
                    }
                    if json["data"].isEmpty {
                        successClosure(json["response"])
                    } else {
                        successClosure(json["data"])
                    }
                    
                } catch {
                    failClosure(self.failInfo)
                }
            case let .failure(error):
                failClosure(error.errorDescription)
            }
        }
    }
    
    ///设置一个公共请求超时时间
    private func requestTimeoutClosure<T:TargetType>(target:T) -> MoyaProvider<T>.RequestClosure{
        let requestTimeoutClosure = { (endpoint:Endpoint, done: @escaping MoyaProvider<T>.RequestResultClosure) in
            do{
                var request = try endpoint.urlRequest()
                request.timeoutInterval = 20 //设置请求超时时间
                done(.success(request))
            }catch{
                return
            }
        }
        return requestTimeoutClosure
    }
}

