//
//  CurrentSheme.swift
//  pr1
//
//  Created by Никита Попов on 19.02.24.
//

import Foundation
import UIKit

struct CurrentSheme{
    static var shared = CurrentSheme()
    private init(){}
    
    var sh: ShemeStyle = .light
}

enum ShemeStyle: String, CaseIterable{
    case sky = "Sky"
    case dark = "Dark"
    case light = "Light"
    
    var bkColor: UIColor{
        switch self{
        case .sky:
            return #colorLiteral(red: 0.4797689915, green: 0.6855362058, blue: 0.743837893, alpha: 1)
        case .dark:
            return #colorLiteral(red: 0.285897553, green: 0.2842893004, blue: 0.2904983759, alpha: 1)
        case .light:
            return #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }
    }
    
    var textColor:UIColor{
        switch self{
        case .sky:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .dark:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .light:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    var font: UIFont{
        switch self{
        case .sky:
            return .systemFont(ofSize: 20, weight: .medium)
        case .dark:
            return .systemFont(ofSize: 20, weight: .bold)
        case .light:
            return .systemFont(ofSize: 20, weight: .light)
        }
    }
}
