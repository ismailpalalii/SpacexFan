//
//  CoreDataFavoriteHelper.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 1.09.2022.
//

import UIKit

// MARK: Create Coredata helper

final class CoreDataFavoriteHelper {

    // MARK: Property
    static let shared = CoreDataFavoriteHelper()

    // swiftlint:disable force_cast
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

// MARK: - FetchData
    func fetchData() -> [Favorites]? {

        do {
            return try self.context.fetch(Favorites.fetchRequest())
        } catch {
            print("error: \(error.localizedDescription)")
        }
        return nil
    }
// MARK: - SaveData
    func saveData(name: String, id: String) {

        let favorite = Favorites(context: context)
        favorite.name = name
        favorite.id = id
        do {
            try self.context.save()
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
// MARK: - DeleteData
    func deleteData(index: Int) {

        if let datas = fetchData() {
            context.delete(datas[index])
            do {
                try self.context.save()
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
