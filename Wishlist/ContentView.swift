//
//  ContentView.swift
//  Wishlist
//
//  Created by Bülent TÜRÜDÜ on 9.07.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
@Environment(\.modelContext) private var modelContext //SwiftData'nın veritabanı bağlamı (ekle/sil/kaydet işlemleri için)
@Query private var wishes: [Wish] // Wish modelinden gelen tüm dilekleri dinamik olarak çekip wishes dizisine atar.
@State private var isAlertShowing: Bool = false // + butonuna basıldığında alert açmak için kontrol
@State private var title: String = "" // Kullanıcının yazdığı dilek metni

var body: some View {
    NavigationStack { // Sayfalar arası geçiş için navigation yapısı (modern SwiftUI yapısı)

        // MARK: - [+] BEGIN: LIST ------------------------->
        // Kullanıcının eklediği tüm dilekleri listeleyen ana görünüm
    List {
        ForEach(wishes) { wish in // Tüm dilekleri sırayla göster
            Text(wish.title)
                .font(.headline.weight(.regular))
                .padding(.vertical, 4)
                .swipeActions {
                    Button("Delete", role: .destructive) { 
                        modelContext.delete(wish) // Dileği sil
                        try? modelContext.save() // Kaydet
                    }
                }
        }
    }
        //-- [-] END:  LIST ------------------------->



        // MARK: - [+] BEGIN: NAVIGATION TITLE SETTINGS ------------------------->
        // Varsayılan başlığı (ortalanmış) devre dışı bırakır.
        // Böylece Toolbar içinde özel hizalanmış başlık kullanılır.
        // Bu ayarlar .toolbar içine alınamaz, NavigationStack seviyesi modifier'lardır.
    .navigationTitle("")
    .navigationBarTitleDisplayMode(.inline)

        //-- [-] END:  NAVIGATION TITLE SETTINGS ------------------------->


        // MARK: - [+] BEGIN: TOOLBAR ------------------------->
        // Üst kısımda yeni dilek ekleme butonu, alt kısımda toplam dilek sayısı gösterilir

    .toolbar {
            // Topbar
        ToolbarItem(placement: .navigationBarLeading){ // Sol üstteki Whislist açıklaması
            Text("Wishlist")
                .font(.title)
                .bold()
        }
        ToolbarItem(placement: .topBarTrailing){ // Sağ üstteki + butonu
            Button {
                isAlertShowing.toggle()

            } label: {
                Image(systemName: "plus")
                    .imageScale(.large)
            }
        }
            // Bottombar
        if !wishes.isEmpty {
            ToolbarItem(placement: .bottomBar){
                Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : "")") // Toplam dilek sayısı
            }
        }
    }

        //-- [-] END:  TOOLBAR ------------------------->


        // MARK: - [+] BEGIN: ALERT ------------------------->
        // Yeni dilek eklemek için açılan uyarı penceresi (alert).
        // TextField ile kullanıcıdan metin alır.
        // "Save" butonuna basıldığında, yeni dilek veritabanına kaydedilir.
        // Dilek eklendikten sonra giriş alanı temizlenir.

    .alert("Create a new wish", isPresented: $isAlertShowing){ // + butonuna basınca çıkan alert
        TextField("Enter a wish", text: $title)  // Kullanıcıdan metin al
        Button {
            guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return } // Boş veri koruması
            modelContext.insert(Wish(title: title)) // Yeni dileği veritabanına ekle
            try? modelContext.save()
            title = "" // TextField'ı temizle
        } label: {
            Text("Save") // Kaydet butonu
        }
    }
        //-- [-] END:  ALERT ------------------------->

        // MARK: - [+] BEGIN: OVERLAY ------------------------->
        // Zemin görünümü (overlay), liste boş olduğunda kullanıcıya bilgi verir.
        // "No wishes yet" mesajıyla kullanıcıyı yönlendirir ve etkileşim başlatır.
        // ContentUnavailableView kullanarak görsel ve açıklama sunar.
    .overlay {
        if wishes.isEmpty {
            ContentUnavailableView( // Eğer dilek yoksa bilgi ekranı göster
                "My Wishlist",
                systemImage: "heart.circle",
                description: Text("No wishes yet. Add one to get started."))
        }
    }

        //-- [-] END:  OVERLAY ------------------------->



    } //: End - NagivationStack
} //: End - BodyView
} //: End - ContentView

#Preview("List with Sample Data"){
let container = try! ModelContainer(for:Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

container.mainContext.insert(Wish(title: "Master SwiftData"))
container.mainContext.insert(Wish(title: "Buy a new iPhone"))
container.mainContext.insert(Wish(title: "Practice latin dances"))
container.mainContext.insert(Wish(title: "Travel to Europe"))
container.mainContext.insert(Wish(title: "Make a positive impact"))

return ContentView()
    .modelContainer(container)
}

#Preview("Empty List") {
ContentView()
    .modelContainer(for:Wish.self, inMemory: true)
}
