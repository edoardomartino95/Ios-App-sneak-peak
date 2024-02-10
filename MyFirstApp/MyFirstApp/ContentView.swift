//
//  ContentView.swift
//  MyFirstApp
//
//  Created by Edoardo Martino on 06/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isOpen = false
    @State private var openone = false
    @State private var opentwo = false
    @State private var openthree = false
    @State private var openfour = false
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                header
                myspace
                blockone
                blocktwo
                blockthree
                blockfour
                Spacer()
            }
            .padding()
        }
       
}
    var header: some View{
        HStack(alignment: .lastTextBaseline){
            Text("Benvenuto")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            
            Button(action: {
                isOpen.toggle()
            },label:{
                VStack{
                    Image(systemName: "line.horizontal.3")
                        .font(.largeTitle)
                }
            })
        }
        .sheet(isPresented: $isOpen){
            VStack(alignment: .leading){
                HStack{
                    Button(action: {

                    },label:{
                        HStack{
                            Image(systemName: "person")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Text("Profilo")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                    })
                }
                .padding(.top, 30)

                HStack{
                    Button(action: {
                    },label:{

                        HStack{
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Text("Messaggi")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                    })
                }
                .padding(.top, 30)

                HStack{
                    Button(action: {

                    },label:{
                        HStack{
                            Image(systemName: "gear")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Text("Impostazioni")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                    })
                }
                .padding(.top, 30)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .topTrailing)
        }
        .padding(.vertical, 10)
        .foregroundStyle(.black)
    }
    
    var myspace: some View{
        HStack{
            VStack{
                Text("SPAZZI: ")
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            .foregroundStyle(.gray)
        }
    }
    
    var blockone: some View{
            HStack(alignment: .lastTextBaseline){
                Button(action: {
                    openone.toggle()
                },label:{
                    VStack{
                        Text("PLASTICA E ALLUMINIO")
                            .fontWeight(.bold)
                    }
                })
                Spacer()
            }
            .sheet(isPresented: $openone){
                Text("Prova")
            }
            .padding(20)
            .foregroundStyle(.white)
            .background{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.orange)
            }

    }
    
    var blocktwo: some View{
            HStack(alignment: .lastTextBaseline){
                Button(action: {
                    opentwo.toggle()
                },label:{
                    VStack{
                        Text("CARTA")
                            .fontWeight(.bold)
                    }
                })
                Spacer()
        }
            .sheet(isPresented: $opentwo){
                Text("Prova")
            }
            .padding(20)
            .foregroundStyle(.white)
            .background{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.blue)
            }
        
    }
    
    var blockthree: some View{
            HStack(alignment: .lastTextBaseline){
                Button(action: {
                    openthree.toggle()
                },label:{
                    VStack{
                        Text("VETRO")
                            .fontWeight(.bold)
                    }
                })
                Spacer()
        }
            .sheet(isPresented: $openthree){
                Text("Prova")
            }
            
            .padding(20)
            .foregroundStyle(.white)
            .background{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.green)
            }
        
    }
    
    var blockfour: some View{
            HStack(alignment: .lastTextBaseline){
                Button(action: {
                    openfour.toggle()
                },label:{
                    VStack{
                        Text("UMIDO")
                            .fontWeight(.bold)
                    }
                })
                Spacer()
        }
            .sheet(isPresented: $openfour){
                Text("Prova")
            }
            
            .padding(20)
            .foregroundStyle(.white)
            .background{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.brown)
            }
        
    }

        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
