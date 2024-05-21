//
//  Test1ViewContainer.swift
//
//
//  Created by ohayoukenchan on 2024/04/30.
//

import Core
import SwiftUI

struct Test1ViewContainer: View {
    var name: String?

    var body: some View {
        if let name {
            Text(name)
        }
    }
}

#Preview {
    Test1ViewContainer()
}
