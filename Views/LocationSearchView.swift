//
//  LocationSearchView.swift
//  Uber
//
//  Created by Luciano Nicolini on 27/09/2022.
//

import SwiftUI

struct LocationSearchView: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 8,height: 8)
                .padding(.horizontal)
                
            //darkGray
            Text("Donde quieres ir?")
                .foregroundColor(Color(.white))
                .fontWeight(.medium)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            Rectangle()
                .fill(Color.black)
                .shadow(color: .black, radius: 3)
                .cornerRadius(8)
            
        )
        
        

    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
