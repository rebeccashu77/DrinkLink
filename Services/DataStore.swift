//
//  DataStore.swift
//  DrinkLink
//
//  Created by Yume Choi on 3/17/22.
//

import Foundation

class DataStore: ObservableObject {
    @Published var profiles: [Profile] = Profile.Data
  @Published var currentUsername: String?
    //@Published var newprofile: Profile?
    //@Published var profileList: [Profile] = Profile.Data
  @Published var drinks: [Drink] = Drink.previewData
  @Published var businesses: [Business] = []

    func fetchProfile(username: String) -> Profile? {
        return profiles.filter { $0.username == username.lowercased() }.first
    }
    
    func addProfile(_ profile: Profile) {
        profiles.append(profile)
    }
    
    func updateProfile(_ profile: Profile) {
        if let index = profiles.firstIndex(where: { $0.id == profile.id }) {
            profiles[index] = profile
        }
    }
    
    func deleteProfile(_ profile: Profile) {
        if let index = profiles.firstIndex(where: { $0.id == profile.id }) {
            profiles.remove(at: index)
        }
    }
  
  func createDrink(_ drink: Drink) {
    drinks.append(drink)
  }
  
  func addDrinktoUser(_ profile: Profile, drink: Drink) {
    if let index = profiles.firstIndex(where: { $0.id == profile.id }) {
      profiles[index].drinks.append(drink)
    }
  }
    
    func deleteDrink(_ profile: Profile, _ drink: Drink) {
        if let index = profiles.firstIndex(where: { $0.id == profile.id }) {
            if let index2 = profiles[index].drinks.firstIndex(where: { $0.id == drink.id }) {
                profiles[index].drinks.remove(at: index2)
            }
        }
    }
  
  func removeFriend (_ profile: Profile, user: Profile) {
    if let index = profiles.firstIndex(where: { $0.id == profile.id }) {
      if let friendIndex = profiles[index].friends.firstIndex(where: {$0.id == user.id }) {
        profiles[index].friends.remove(at: friendIndex)
      }
    }
  }
  
  func addFriend (_ profile: Profile, user: Profile) {
    if let index = profiles.firstIndex(where: { $0.id == profile.id }) {
      profiles[index].friends.append(user)
    }
  }
  
  private static func fileURL() throws -> URL {
      try FileManager.default.url(for: .documentDirectory,
                                     in: .userDomainMask,
                                     appropriateFor: nil,
                                     create: false)
          .appendingPathComponent("drinks.data")
  }

  static func load() async throws -> [Drink] {
      try await withCheckedThrowingContinuation { continuation in
          load { result in
              switch result {
              case .failure(let error):
                  continuation.resume(throwing: error)
              case .success(let drinks):
                  continuation.resume(returning: drinks)
              }
          }
      }
  }

  static func load(completion: @escaping (Result<[Drink], Error>)->Void) {
      DispatchQueue.global(qos: .background).async {
          do {
              let fileURL = try fileURL()
              guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                  DispatchQueue.main.async {
                    // HACK TO GET US UP AND RUNNING WITH DATA
                    completion(.success(Drink.previewData))
//                      completion(.success([]))
                  }
                  return
              }
            let drinks = try JSONDecoder().decode([Drink].self, from: file.availableData)
              DispatchQueue.main.async {
                  completion(.success(drinks))
              }
          } catch {
              DispatchQueue.main.async {
                  completion(.failure(error))
              }
          }
      }
  }

  @discardableResult
  static func save(drinks: [Drink]) async throws -> Int {
      try await withCheckedThrowingContinuation { continuation in
          save(drinks: drinks) { result in
              switch result {
              case .failure(let error):
                  continuation.resume(throwing: error)
              case .success(let drinksSaved):
                  continuation.resume(returning: drinksSaved)
              }
          }
      }
  }

  static func save(drinks: [Drink], completion: @escaping (Result<Int, Error>)->Void) {
      DispatchQueue.global(qos: .background).async {
          do {
              let data = try JSONEncoder().encode(drinks)
              let outfile = try fileURL()
              try data.write(to: outfile)
              DispatchQueue.main.async {
                  completion(.success(drinks.count))
              }
          } catch {
              DispatchQueue.main.async {
                  completion(.failure(error))
              }
          }
      }
  }
}

