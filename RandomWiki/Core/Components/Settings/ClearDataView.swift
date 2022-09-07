//
//  ClearDataView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/7/22.
//

import SwiftUI

struct ClearDataView: View {
    var clearDataAction: SimpleClosure
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button {
            clearDataAction()
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Clear Data")
        }
    }
}

struct ClearDataView_Previews: PreviewProvider {
    static var previews: some View {
        ClearDataView(clearDataAction: {})
    }
}
