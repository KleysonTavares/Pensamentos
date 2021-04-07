//
//  Quote.swift
//  Pensamentos
//
//  Created by Kleyson on 31/03/2021.
//  Copyright © 2021 Kleyson Tavares. All rights reserved.
//

import Foundation

struct Quote: Codable {
    let quote: String
    let author: String
    let image: String
    
    var quoteFormatted: String {
        return "“" + quote + "” "
    }
    
    var authorFormatted: String {
        return " -" + author + "- "
    }
}

