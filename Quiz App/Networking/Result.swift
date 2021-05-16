//
//  Result.swift
//  Quiz App
//
//  Created by Leo Skarpa on 14.05.2021..
//

import Foundation
import UIKit

enum Result<Success, Failure> where Failure : Error{
    case success(Success)
    case failure(Failure)
}

