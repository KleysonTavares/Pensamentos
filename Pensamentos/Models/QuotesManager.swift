//
//  QuotesManager.swift
//  Pensamentos
//
//  Created by Kleyson on 31/03/2021.
//  Copyright © 2021 Kleyson Tavares. All rights reserved.
//

import Foundation
final class QuotesManager {

    let quotes: [Quote]
    
    init( ) {
        let fileURL = Bundle.main.url(forResource: "quotes", withExtension: "json")!
        let jsonData = try! Data(contentsOf: fileURL)
        let jsonDecoder = JSONDecoder()
        quotes = try! jsonDecoder.decode([Quote].self, from: jsonData)
    }
    func getRandomQuote () -> Quote {
        let index = Int(arc4random_uniform(UInt32(quotes.count)))
        return quotes[index]
    }
}
