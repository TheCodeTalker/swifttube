//
//  APIClient.swift
//  App
//
//  Created by Ahmet Yalcinkaya on 02/12/2018.
//

import Foundation
import MongoKitten

class APIClient: APIProtocol {
    
    let database: Database?
    
    init(databaseUrl: String?) {
        if let url = databaseUrl {
            database = try? Database(url)
        } else {
            database = nil
            assert(false, "URL can not be nil")
        }
    }
    
    func getFeaturedVideos() -> Array<Document>? {
        guard let database = database else { return nil }
        
        guard let videos = try? Array(database["videos"].find("featured" == true)) else {
            return nil
        }
        return videos
    }
    
    func getVideo(shortUrl: String) -> Document? {
        guard let database = database else { return nil }

        guard let video = try? database["videos"].findOne("shortUrl" == shortUrl) else {
            return nil
        }
        return video
    }
    
    //MARK: - Speakers
    
    func getSpeakers() -> Array<Document>? {
        guard let database = database else { return nil }
        
        guard let speakers = try? Array(database["users"].find()) else {
            return nil
        }
        return speakers
    }
    
    func getSpeaker(shortUrl: String) -> Document? {
        guard let database = database else { return nil }
        
        guard let speaker = try? database["users"].findOne("shortname" == shortUrl) else {
            return nil
        }
        return speaker
    }
}
