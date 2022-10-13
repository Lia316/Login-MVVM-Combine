//
//  ViewModel.swift
//  Login+Combine
//
//  Created by 리아 on 2022/10/04.
//

import Foundation
import Combine

final class ViewModel {
    
    // Input
    @Published var idText = ""
    @Published var pwText = ""
    
    // Output
    @Published var isIDValid = false
    @Published var isPWValid = false
    @Published var isBothValid = false
    
    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        $idText
            .map(checkIDValid)
            .assign(to: \.isIDValid, on: self)
            .store(in: &cancelBag)
        
        $pwText
            .map(checkPWValid)
            .assign(to: \.isPWValid, on: self)
            .store(in: &cancelBag)
        
        $isIDValid.combineLatest($isPWValid)
            .map(checkBothValid)
            .assign(to: \.isBothValid, on: self)
            .store(in: &cancelBag)
    }
    
}

// Logic

extension ViewModel {

    private func checkIDValid(id: String) -> Bool {
        return id.count > 5
    }
    
    private func checkPWValid(pw: String) -> Bool {
        return pw.count > 7
    }
    
    private func checkBothValid(id: Bool, pw: Bool) -> Bool {
        return id && pw
    }
    
}
