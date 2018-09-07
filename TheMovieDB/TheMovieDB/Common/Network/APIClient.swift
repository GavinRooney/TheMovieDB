//
//  APIClient.swift
//  TheMovieDB
//
//  Created by Gavin on 07/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation
import Alamofire


struct ApiClientError: Error {
    var errorMessage: String?
    var notConnected: Bool?
}


class ApiAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        // This is a very simple api client but for complicated version we could set up additional headers here
        // for client ids, tokens, app versions etc
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        guard let APIKey = Settings.sharedInstance.environmentKey else {
            print("API Key is missing!")
            // in this example we will make the call anyway
            return urlRequest
        }
        
        print("API Key to be used: \(APIKey)\n")

        if let url = urlRequest.url, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            
            let queryItemKey = URLQueryItem(name: "api_key", value: APIKey)
            components.queryItems?.append(queryItemKey)
            urlRequest.url = components.url
        }
        
        
        return urlRequest
    }
}


class RetryHandler: RequestRetrier {
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        
        if (request.retryCount < 2) {
            if (error._code == NSURLErrorNotConnectedToInternet) {
                completion(true, 2.0) // retry after 2 second
            } else if (error._code == NSURLErrorTimedOut) {
                completion(true, 0.0)
            } else {
                completion(false, 0.0)
            }
        } else {
            completion(false, 0.0)
        }
    }
}


class ApiClient {
    
    static let sessionManager = SessionManager()
    static let reachablity = NetworkReachabilityManager()
    static var ApiURL: String {
        return Settings.sharedInstance.environmentUrl
    }
    
    
    class var hasWorkingInternetConnection: Bool {
        return reachablity!.isReachable
    }
    

    @discardableResult
    static func sendRequest<T: Decodable>(
        _ request: ApiRequest,
        responseType: T.Type,
        completion: @escaping (T?) -> Void,
        failure: @escaping (Error?) -> Void
        ) -> DataRequest? {
        
        if (ApiClient.hasWorkingInternetConnection) {
            
            let url = ApiClient.ApiURL + "/\(request.url)"
            let method = request.method
            let parameters = request.parameters
            
            sessionManager.retrier = RetryHandler()
            sessionManager.adapter = ApiAdapter()
            
            let dataRequest = sessionManager
                .request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .response { responseResult in
                    
                    if responseResult.error != nil {
                        failure(responseResult.error)
                        return
                    }
                    
                    guard responseResult.response != nil else {
                        let error = ApiClientError(errorMessage: "ApiClient response is nil", notConnected: false)
                        failure(error)
                        return
                    }
                    
                    let apiResponse: T? = {
                        if let data = responseResult.data {
                            return JSONHelpers.decode(responseType, from: data)
                        }
                        return nil
                    }()
                    
                    
                    if apiResponse == nil {
                        let error = ApiClientError(errorMessage: "ApiClient response cannot be decoded", notConnected: false)
                        failure(error)
                        return
                    }
                    
                    completion(apiResponse)
            }
            return dataRequest
            
        } else {
            let error = ApiClientError(errorMessage: "PLEASE_CHECK_INTERNET".localized, notConnected: true)
            failure(error)
            return nil
        }
    }
}


