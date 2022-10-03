//
//  LocationSearchViewInterface.swift
//  Uber
//
//  Created by Luciano Nicolini on 27/09/2022.
//

import SwiftUI

struct LocationSearchViewInterface: View {
    @State private var startLocationText = ""
    //@State private var destinationLocationText = ""
    @Binding var showLocationSearchView: Bool
    @EnvironmentObject var viewModel: LocationSearchModel
    
    var body: some View {
        VStack {
            //heder View
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width: 6, height: 6)
                    
                }
                
                VStack {
                    TextField("Elgie un punto de partida", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    
                    TextField("Elige un punto de destino", text: $viewModel.queryFragement)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                    
            
                }
            }
            .padding(.leading)
            .padding(.top,64)
            
            Divider()
                .padding(.vertical)
         
            //list View
           
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.results, id: \.self) { index in
                        LocationSearchResultCell(tilte: index.title, subtitle: index.subtitle)
                            .onTapGesture {
                                viewModel.selectLocation(index)
                                showLocationSearchView.toggle()
                            }
                        
                    }
                }
            }
        }
        .background(.white)
    }
}

struct LocationSearchViewInterface_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchViewInterface(showLocationSearchView: .constant(false))
    }
}
