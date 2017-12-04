//
//  NetworkManager.swift
//  CarList
//
//  Created by Vlad Che on 11/30/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import Foundation
import Moya
import Unbox
import RxSwift
import Result

protocol Target: TargetType {
    associatedtype ResultType: Unboxable
}

extension MoyaProvider {
    static var `default`: MoyaProvider<Target> {
        return MoyaProvider(endpointClosure: MoyaProvider.defaultEndpointMapping,
                            requestClosure: MoyaProvider.defaultRequestMapping,
                            stubClosure: MoyaProvider.neverStub,
                            callbackQueue: nil,
                            manager: MoyaProvider<Target>.defaultAlamofireManager(),
                            plugins: [logger, activityPlugin],
                            trackInflights: false)
    }
    
    private static var logger: NetworkLoggerPlugin { return NetworkLoggerPlugin(verbose: true, cURL: true) }
    
    private static var activityPlugin: NetworkActivityPlugin {
        return NetworkActivityPlugin() { state, target in
            switch state {
            case .began: print("======= began activity for \(String(describing:target))")
            case .ended: print("======= ended activity for \(String(describing:target))")
            }
        }
    }
}

extension MoyaProvider where Target: CarList.Target {
    
    func request(_ target: Target,
                 callbackQueue: DispatchQueue? = .none,
                 progress: ProgressBlock? = .none,
                 completion: @escaping (_ result: Result<Target.ResultType, MoyaError>) -> ()) -> Cancellable {
        return request(target, callbackQueue: callbackQueue, progress: progress) { (result: Result<Moya.Response, MoyaError>) in
            switch result {
            case .success(let response):
                do {
                    let parsed: Target.ResultType = try unbox(data: response.data)
                    completion(.success(parsed))
                } catch {
                    completion(.failure(.jsonMapping(response))) //TODO: Error handling
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

extension Reactive where Base: MoyaProviderType, Base.Target: CarList.Target {
    func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Base.Target.ResultType> {
        let single: Single<Response> = request(token, callbackQueue: callbackQueue)
        return single.map { response in
            let parsed: Base.Target.ResultType = try unbox(data: response.data)
            return parsed
        }
    }
}


