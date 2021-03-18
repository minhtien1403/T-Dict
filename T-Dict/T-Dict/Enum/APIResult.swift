//
//  APIResult.swift
//  T-Dict
//
//  Created by Tiến on 3/18/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation

enum APIResult {
    case success(Data?)
    case failure(APIError)
}

enum APIError: Error {
    case failedToGetDataFromAPI
    case failedToGetURL
}
