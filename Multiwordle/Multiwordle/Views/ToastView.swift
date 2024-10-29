//
//  ToastView.swift
//  Multiwordle
//
//  Created by EJ Gaygay on 10/27/24.
//

/*
  The toast celebration or guess warning view
 */
import SwiftUI

struct ToastView: View {
    let toastText: String
    var body: some View {
        Text(toastText)
            .foregroundColor(.systemBackground)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.primary))
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(toastText: "Not in word list.")
    }
}
