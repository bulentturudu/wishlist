//
//  WishlistApp.swift
//  Wishlist
//
//  Created by Bülent TÜRÜDÜ on 9.07.2025.
//

//
// MARK: - Uygulama Giriş Noktası (App Entry Point)
// Açıklama: Wishlist uygulaması buradan başlar. Ana görünüm ContentView'dur.
// SwiftData ile veri modeli (Wish) burada bağlanır.
//

import SwiftUI
import SwiftData

// MARK: - [+] BEGIN: WishlistApp ------------------------->
// SwiftUI yaşam döngüsüne göre uygulama başlatılır.
// ContentView ana ekran olarak gösterilir.
// SwiftData model container burada tanımlanır.

@main
struct WishlistApp: App {
var body: some Scene {
    WindowGroup {
        ContentView()
            .modelContainer(for: Wish.self)
    }
}
}
//-- [-] END: WishlistApp ------------------------->
