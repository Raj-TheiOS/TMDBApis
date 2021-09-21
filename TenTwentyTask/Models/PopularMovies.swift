//
//  PopularMovies.swift
//  TenTwentyTask
//
//  Created by Arjun  on 30/12/20.
//  Copyright © 2020 Raj. All rights reserved.
//

import Foundation

final class PopularMovies: NSObject, Decodable {
    let poster_path, overview, release_date, original_title, original_language, title ,backdrop_path : String?
    let id,vote_count : Int?
    let vote_average : Float?

}

extension PopularMovies: Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> PopularMovies? {
        let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        guard data != nil else {
            debugPrint("unable to parse: PopularMovies")
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(PopularMovies.self, from: data!)
            return user
        }
        catch {
            print("unable to decode model: PopularMovies")
            return nil
        }
    }
}
