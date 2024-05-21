//
//  Test2ViewContainer.swift
//
//
//  Created by ohayoukenchan on 2024/04/30.
//

import SwiftUI

public struct Test2ViewContainer: View {
    public var action: () -> Void

    public var body: some View {
        Text("test2")
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    Test2ViewContainer(action: {})
}
