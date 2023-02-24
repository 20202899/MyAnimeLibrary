//
//  ShowAnimes.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import Core

enum ShowAnimes {
    enum GetAnimes {
        struct Request {
            
        }
        
        struct Response {
            let result: Result<Animes, HttpErrorType>
        }
        
        struct ViewModel {
            struct AnimeDisplay {
                let name: String
                let imageUrl: String
            }
            
            let animes: [AnimeDisplay]
        }
    }
}
