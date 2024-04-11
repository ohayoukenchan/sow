import Foundation
import RealmSwift

public final class RealmMigrator {

    public static let schemaVersion: UInt64 = 1

    public static func migrate() {
        let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
            /// Realmのマイグレーション時に必要な処理を書く
        }

        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: migrationBlock
        )
        Realm.Configuration.defaultConfiguration = config


        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    public static func deleteRealmFile() {
        #if RELEASE
            /// リリースビルド時はファイルを削除しない
        #else
        if let fileURL = Realm.Configuration.defaultConfiguration.fileURL {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
            }
        }
        #endif
    }
}

