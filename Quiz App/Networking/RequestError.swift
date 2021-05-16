//
//  RequestError.swift
//  Quiz App
//
//  Created by Leo Skarpa on 13.05.2021..
//

import Foundation
import UIKit

enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataEncodingError
}
