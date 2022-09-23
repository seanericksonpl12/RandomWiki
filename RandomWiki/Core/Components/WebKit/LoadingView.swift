//
//  LoadingView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/6/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color("Background")
            LottieView(animationName: "reloading")
                .frame(width: 50)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
