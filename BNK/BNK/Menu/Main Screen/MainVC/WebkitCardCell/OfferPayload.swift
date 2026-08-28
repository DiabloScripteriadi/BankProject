//
//  OfferPayload.swift
//  BNK
//
//  Created by chasemedkcorto on 07.08.26.
//


import Foundation

struct OfferPayload: Codable {
    let offers: [Offer]
}

struct Offer: Codable, Identifiable {
    let id: String
    let brand: String
    let offerTitle: String
    let description: String
    let promoCode: String
    let expiry: String
    let imageURL: String
    let websiteURL: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case id, brand, description, expiry, category
        case offerTitle = "offer_title"
        case promoCode = "promo_code"
        case imageURL = "image_url"
        case websiteURL = "website_url"
    }
}
