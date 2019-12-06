//
//  DateExtension.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/5/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
