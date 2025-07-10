//
//  WishModel.swift
//  Wishlist
//
//  Created by Bülent TÜRÜDÜ on 9.07.2025.
//

//
// MARK: - Model: Wish
// Bu model, kullanıcının eklediği dilekleri temsil eder.
// SwiftData tarafından veritabanında saklanmak üzere işaretlenmiştir.
//

import Foundation
import SwiftData

// MARK: - [+] BEGIN: Wish Model -------------------------->
// Model: Her dilek bir başlık içerir ve SwiftData ile kalıcı olarak saklanır.
@Model
class Wish {
var title: String

    // Kullanıcının girdiği başlığı modele aktarır.
init(title: String) {
    self.title = title
}
}
//-- [-] END: Wish Model -------------------------->
