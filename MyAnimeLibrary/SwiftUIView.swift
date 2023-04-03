//
//  SwiftUIView.swift
//  MyAnimeLibrary
//
//  Created by Carlos Silva on 26/02/23.
//

import SwiftUI
import Presentations

struct MyView_Representable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return LayoutDrawableConcrete
            .start()
            .drawableView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

struct MyViewProvider_Previews: PreviewProvider {
    static var previews: some View {
        MyView_Representable()
    }
}
