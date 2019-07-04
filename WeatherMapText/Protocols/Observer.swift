//
//  Observer.swift
//  WeatherMapText
//
//  Created by  Arthur Bodrov on 03/07/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import Foundation

protocol Observer {
    var id: String { get set }
    func update(value: Int?)
}
