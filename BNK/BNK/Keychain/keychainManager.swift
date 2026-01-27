//
//  keychainManager.swift
//  BNK
//
//  Created by chasemedkcorto on 27.01.26.
//

import Foundation
import Security

class KeychainManager: KeychainManagerType {
    static let shared = KeychainManager()
    
    func getPasscode() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "user_passcode",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess else { return nil }
        guard let passcodeData = result as? Data,
              let passcode = String(data: passcodeData, encoding: .utf8) else { return nil }
        return passcode
    }
    
    func savePasscode(_ passcode: String) -> Bool {
        guard let passcodeData = passcode.data(using: .utf8) else { return false }
        
        if getPasscode() != nil {
            return updatePasscode(passcodeData)
        } else {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: "user_passcode",
                kSecValueData as String: passcodeData,
         
                kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
            ]
            let status = SecItemAdd(query as CFDictionary, nil)
            return status == errSecSuccess
        }
    }
    
    func deletePasscode() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "user_passcode"
        ]
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    
    func updatePasscode(_ passcodeData: Data) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "user_passcode"
        ]
        let updateQuery: [String: Any] = [
            kSecValueData as String: passcodeData
        ]
        let status = SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
        return status == errSecSuccess
    }
}
