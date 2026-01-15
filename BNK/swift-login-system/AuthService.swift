//
//  AuthService.swift
//  BNK
//
//  Created by chasemedkcorto on 16.01.26.
//
import Foundation
class AuthService {
    public static let shared = AuthService()
    private init() {}
}
class A {
    private func lol() {
        AuthService.shared.lol()
    }
}
