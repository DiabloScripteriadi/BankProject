//
//  Constants.swift
//  BNK
//
//  Created by chasemedkcorto on 21.07.26.
//

import UIKit

/// აქ მოვუყაროთ თავი მაგიურ სტრინგებს/რიცხვებს/სურათების სახელებს/URL-ებს.
enum Constants {
    enum UserDefaultsKeys {
        static let selectedLanguage = "app.selectedLanguage"
    }

    enum ReuseID {
        static let profileRowCell = "ProfileRowCell"
        static let transactionCell = "TransactionCell"
        static let contactsCell = "ContactsCell"
        static let cardsCell = "CardsCell"
    }

    enum URLs {
        static let privacyPolicy = "https://www.apple.com/legal/privacy/"
        static let invest = "https://www.bybit.com/en/"
        static let bet = "https://asvla.com"
        //airtime
    }

    enum Layout {
        static let tableMinHeight: CGFloat = 500
        static let defaultCornerRadius: CGFloat = 16
        static let defaultShadowOpacity: Float = 0.06
    }

    enum Symbols {
        static let personCircle = "person.circle"
        static let globe = "globe"
        static let lockShield = "lock.shield"
        static let bellBadge = "bell.badge"
        static let logout = "rectangle.portrait.and.arrow.right"
        static let chevronRight = "chevron.right"
        static let iphone = "iphone"
        static let plus = "plus"
    }
}

