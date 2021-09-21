//
//  WebService.swift
//  TenTwentyTask
//
//  Created by Arjun  on 30/12/20.
//  Copyright © 2020 Raj. All rights reserved.
//

import Foundation
import UIKit

class WebService: RequestHandler {
    
    //MARK:- Server Handler -- connect to server -- 
    private class func connectToServer(_ api: APIConstants, httpMethod method: HTTPMethod,query queryItems: Parameters? = nil, completion:@escaping (Result<Data,ErrorResult>)->Void) {
        
        // check rechability
        if !reachability.isReachable {
            self.showRetryAlert(message: "No Internet Connection", api: api, httpMethod: method, query: queryItems, completion: completion)
            return
        }
        
        let cookieStore = HTTPCookieStorage.shared
        for cookie in cookieStore.cookies ?? [] {
            cookieStore.deleteCookie(cookie)
        }

        // url request
        let internalRequest = RequestBuilder.buildRequest(api: api,
                                                          method: method,
                                                          parameters: queryItems)
        // check request before session
        guard let request = internalRequest else {
            debugPrint("invalid request")
            return
        }
        
        // session
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard data != nil else {
                let serverError = "Unable to connect to server. please try again after sometime."
                self.showRetryAlert(message: error?.localizedDescription ?? serverError, api: api, httpMethod: method,query: queryItems, completion: completion)
               return
            }
            
            completion(.success(data!))
        }

        task.resume()
    }
    
    class func showRetryAlert(message: String, api: APIConstants, httpMethod method: HTTPMethod,query queryItems: Parameters? = nil, completion:@escaping (Result<Data,ErrorResult>)->Void) {
        
        DispatchQueue.main.async {
            guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
            guard let controller = delegate.window?.rootViewController else { return }
            
            let alert = UIAlertController.init(title: nil, message: message, preferredStyle: .alert)
            let action = UIAlertAction.init(title: "Retry", style: .default) { (_) in
                self.connectToServer(api, httpMethod: method, query: queryItems, completion: completion)
            }
            alert.addAction(action)
            
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:- popular
    class func popular(queryItems: Parameters, completion:@escaping ((Result<Response<PopularMovies>, ErrorResult>) -> Void)) {
        self.connectToServer(.popular, httpMethod: .GET, query: queryItems, completion: self.networkResult(completion: completion))
    }
    


}







