//
//  TextField+Publisher.swift
//  Login+Combine
//
//  Created by 리아 on 2022/10/04.
//

import Combine
import UIKit

extension UITextField {
    
    var publisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .compactMap { $0.text }
            .eraseToAnyPublisher()
    }

}


