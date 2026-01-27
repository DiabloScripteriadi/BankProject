//
//  KeychainManagerType.swift
//  BNK
//
//  Created by chasemedkcorto on 27.01.26.
//

import Foundation
protocol KeychainManagerType {
    func getPasscode() -> String?
    func savePasscode(_ passcode:String) -> Bool
    func deletePasscode() -> Bool
    func updatePasscode(_ passcodeData:Data) -> Bool
    
}
