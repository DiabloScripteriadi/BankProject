//
//  MovieManager.swift
//  BNK
//
//  Created by chasemedkcorto on 07.08.26.
//


import Foundation


class CardManager {
    private var favoriteCard: [Offer] = []
    private var favorites: [Offer] = []
    func getCardCellData(completion: @escaping ([Offer]) -> Void) {
        guard let url = Bundle.main.url(forResource: "poster", withExtension: "json") else {
            print("❌ File poster.json not found in the project bundle.")
            completion([])
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Файловая ошибка: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("მონაცემები არ მოიტანეს")
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let payload = try decoder.decode(OfferPayload.self, from: data)
                
                DispatchQueue.main.async {
                    print("✅ Successfully parsed \(payload.offers.count) items from poster.json")
                    completion(payload.offers)
                }
                
            } catch {
                print("დეკოდირება ვერ შესრულდა  \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
            
        }.resume()
    }
}

