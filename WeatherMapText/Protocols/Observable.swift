//
//  Observable.swift
//  WeatherMapText
//
//  Created by  Arthur Bodrov on 03/07/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import Foundation

protocol Observable {
    func add(observer: Observer)
    func remove(observer: Observer)
    func notifyObservers()
}
