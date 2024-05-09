//
//  ContentView.swift
//  secondApp
//
//  Created by Edoardo Martino on 02/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selezionaPizza: Int = 0
    @State private var quantitaPizza: Int = 0
    
    @State private var selezionaBibita: Int = 0
    @State private var quantitaBibita: Int = 0
   
    
    @State private var couponCode: String = ""
    @State private var prezzoTotale: Float = 0.0
    
    @State private var isDarkModeAttiva: Bool = false
    
    @State private var isSend: Bool = false
    
//  ARRAY CON NOME PIZZA E PREZZI
    let nomiPizze: [String] = ["Nessuna", "Margherita", "Quattro Formaggi", "Diavola", "Valtellina"]
    let prezziPizze: [Float] = [0.0, 5.0, 7.50, 6.0, 8.0]
//  ARRAY CON NOME BIBITA E PREZZI
    let nomiBibite: [String] = ["Nessuna", "Acqua Naturale", "Acqua Frizzante", "Fanta", "Coca Cola", "Coca Cola Zero", "Sprite", "Monster", "Red Bull"]
    let prezziBibite: [Float] = [0.0, 0.50, 0.50, 2.0, 2.0, 2.0, 2.0, 2.50, 2.00]
    
//   permette di controllare i vari coupond validi
    var code: Int {
        switch couponCode {
        case "MYPIZZA1": return 1
        case "MYPIZZA2": return 2
        default: return 0
        }
    }
        
    var body: some View {
      NavigationView{
//          Ho il form quindi non serve una navigationview
             Form{
                 mypizza
//               non serve il mystepper se non seleziono la pizza,
//               per cui lo inserisco in un if, e verifico se la
//               selezione sia maggiore di zero.
                 
                if selezionaPizza > 0 {
                    mystepper
                    mybibita
                    if selezionaBibita > 0 {
                        mystepperdue
                   }
                    mycoupon
                    myprezzo
                 }
                 
               }
          
             .navigationTitle("Menù")
//            pulsante di reset
             .navigationBarItems(leading: Button(
                action: {
                reset(quantitaPizza: &quantitaPizza, selezionaPizza: &selezionaPizza, quantitaBibita: &quantitaBibita, selezionaBibita: &selezionaBibita, couponCode: &couponCode)
            }){
                Text("Annulla")
            })
//            componente per la dark mode
             .navigationBarItems(trailing: Button(
            action: {
                isDarkModeAttiva.toggle()
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkModeAttiva ? .dark : .light
                // Imposta la modalità scura di sistema
                // accedo all'oggetto UIApplication condiviso e ottengo la finestra principale dell'applicazione. Questo è il punto di accesso per gestire le proprietà dell'interfaccia utente dell'applicazione.
          })
            {
//            se la darkmode è attiva cambia gli stati del pulsante dalla luna al sole
              if isDarkModeAttiva{
                  myblack
              }else {
                  mywhite
              }
            }) //qua finisce la struttura del pulsante per la dark mode
       }
        
    }
    
//  richiamo le funzioni all'interno di mymenu e mystepper
    var mypizza: some View{
        pizza(selezionaPizza: $selezionaPizza, arr: nomiPizze, prez: prezziPizze)
    }
    var mystepper: some View{
        step(pizzaQuantity: $quantitaPizza)
     }
    
    
    var mycoupon: some View{
        coupon(coup: $couponCode, code: self.code)
    }
    var myprezzo: some View{
        prezzo(prez: calcolaPrezzoTotale(quantitaPizza: self.quantitaPizza, selezionaPizza: self.selezionaPizza, quantitaBibita: self.quantitaBibita, selezionaBibita: self.selezionaBibita, couponCode: self.couponCode, prezziPizze: self.prezziPizze, prezziBibite: self.prezziBibite), isSend: $isSend)
    }
    
    
    var mybibita: some View{
        bibita(selezionaBibita: $selezionaBibita, arr: nomiBibite, prez: prezziBibite)
    }
    
    var mystepperdue: some View{
        stepdue(bibitaQuantity: $quantitaBibita)
    }
    
//  grafica per il pulsante della luna in light mode
    var mywhite: some View{
        Image(systemName: "moon.fill")
            .padding(4)
            .background(Color.black)
            .clipShape(Circle())
            .foregroundColor(.white)
    }
//  grafica per il pulsante del sole in dark mode
    var myblack: some View{
        Image(systemName: "sun.max.fill")
            .padding(4)
            .background(Color.white)
            .clipShape(Circle())
            .foregroundColor(.black)
    }
}

// selettore pizza
func pizza(selezionaPizza: Binding<Int>, arr: [String], prez: [Float]) -> some View{ //questa parte mi permette di cattura il tag
   Section{
       Picker(selection: selezionaPizza, label: Text("Pizza")){
           ForEach(0..<arr.count){
               i in Text("\(arr[i]): \(prez[i], specifier: "%.2f") €").tag(i)
           }
       }
   } header: {
       Text("Tipi di Pizza")
   }

}

// selettore bibita
func bibita(selezionaBibita: Binding<Int>, arr: [String], prez: [Float]) -> some View{
    Section{
        Picker(selection: selezionaBibita, label: Text("Bibita")){
            ForEach(0..<arr.count){
                i in Text("\(arr[i]): \(prez[i], specifier: "%.2f") €").tag(i)
            }
        }
    } header: {
        Text("Tipo di bibita")
    }
}

//stepper bibite
func stepdue(bibitaQuantity: Binding<Int>) -> some View{
    Section{
        Stepper(value: bibitaQuantity,
                in: 0...10){
//                per accedere al valore uso wrappedValue
            Text("Quantità: \(bibitaQuantity.wrappedValue)")
        }
    } header: {
        Text("Quante bibite")
    }
}

//funzione stepper, mi crea uno pulsante stepper per la pizza
func step(pizzaQuantity: Binding<Int>) -> some View{
    Section{
        Stepper(value: pizzaQuantity,
                in: 0...10){
//                per accedere al valore uso wrappedValue
            Text("Quantità: \(pizzaQuantity.wrappedValue)")
        }
    } header: {
        Text("Quante pizze")
    }
}

//la funzione ne definisce il controllo del coupon appoggiandosi allo switch case nella var mycoupon
func coupon(coup: Binding<String>, code: Int) -> some View{
    Section{
        TextField("...", text: coup)
    } header: {
        Text("Codice")
    } footer: {
//      Se il coupon è valido allora esce la scritta in verde
//      altrimenti esce la scritta rossa
        if code == 0 && !coup.wrappedValue.isEmpty{
            Text("Coupon non valido")
                .foregroundStyle(.red)
        }else if code == 1 || code == 2{
            Text("Coupon valido")
                .foregroundStyle(.green)
        }
    }
    
}
// permette di generare il prezzo nella section e di simulare l'invio. (è stata la parte più difficile)
func prezzo(prez: Float, isSend: Binding<Bool>) -> some View {
    Section(){
        HStack {
            Text("Totale: \(String(format: "%.2f", prez)) €")
            Spacer()
            Button(action: {
                if prez > 0{
                    isSend.wrappedValue = true
                }
            }) {
                Text("Ordina")
                    .padding(.horizontal, 4)
                    .padding(.vertical, 5)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .frame(width: 60)
            .buttonStyle(PlainButtonStyle())
        }
    } header: {
            Text("Prezzo Totale")
    } footer: {
        //accedo con valore wrappedValue
        if isSend.wrappedValue{
            Text("Ordine inviato!")
                .foregroundColor(.green)
        }
    }
}
// calcolo il prezzo totale e quello scontato se cè lo sconto
func calcolaPrezzoTotale(quantitaPizza: Int, selezionaPizza: Int, quantitaBibita: Int, selezionaBibita: Int, couponCode: String, prezziPizze: [Float], prezziBibite: [Float]) -> Float {
    let prezzoPizze = prezziPizze[selezionaPizza] * Float(quantitaPizza)
    let prezzoBibite = prezziBibite[selezionaBibita] * Float(quantitaBibita)
    let prezzoSenzaSconto = prezzoPizze + prezzoBibite
    let sconto: Float = couponCode == "MYPIZZA1" || couponCode == "MYPIZZA2" ? 0.25 : 0
    return prezzoSenzaSconto * (1 - sconto) //5€ * (1 - 0.25) = 5 * 0.75 = 3.75€ ecco come si può scontare
}

//funzione reset se il pulsante viene premuto viene resettato tutto
func reset(quantitaPizza: inout Int, selezionaPizza: inout Int, quantitaBibita: inout Int, selezionaBibita: inout Int, couponCode: inout String) {
    quantitaPizza = 0
    selezionaPizza = 0
    quantitaBibita = 0
    selezionaBibita = 0
    couponCode = ""
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
