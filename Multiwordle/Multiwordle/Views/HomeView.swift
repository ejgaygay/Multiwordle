//
//  HomeView.swift
//  Multiwordle
//
//  Created by EJ Gaygay on 10/27/24.
//
import SwiftUI

struct HomeView: View {
    @StateObject var dm = DataModel()
    @StateObject var daily = DataModel()
    @StateObject var csManager = ColorSchemeManager()
    
    // State variables for animation
    @State private var welcomeTextOpacity: Double = 0.0
    @State private var titleTextOpacity: Double = 0.0
    @State private var timedleOpacity: Double = 0.0
    @State private var infinidleOpacity: Double = 0.0

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to")
                    .opacity(welcomeTextOpacity)
                    .animation(.easeIn(duration: 1), value: welcomeTextOpacity)
                
                Text("MULTIWORDLE")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
                    .opacity(titleTextOpacity)
                    .animation(.easeIn(duration: 1).delay(0.5), value: titleTextOpacity)
                
                Spacer()
                
                NavigationLink(destination: DailyView()
                    .environmentObject(daily)
                    .environmentObject(csManager)
                    .onAppear {
                        csManager.applyColorScheme()
                    }) {
                    Text("Timedle")
                        .font(.title)
                        .padding()
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .opacity(timedleOpacity)
                        .animation(.easeIn(duration: 1).delay(1.0), value: timedleOpacity) // Delay for fade-in
                }
                
                NavigationLink(destination: GameView()
                    .environmentObject(dm)
                    .environmentObject(csManager)
                    .onAppear {
                        csManager.applyColorScheme()
                    }) {
                    Text("Infinidle")
                        .font(.title)
                        .padding()
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .opacity(infinidleOpacity)
                        .animation(.easeIn(duration: 1).delay(1.5), value: infinidleOpacity) // Delay for fade-in
                }
                
                /*
                NavigationLink(destination: HeadToHead()
                    .environmentObject(dm)
                    .environmentObject(csManager)
                    .onAppear {
                        csManager.applyColorScheme()
                    }) {
                        Text("Head2Headle")
                            .font(.title)
                            .padding()
                            .background(.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .opacity(headToHeadOpacity) // Add this line
                            .animation(.easeIn(duration: 1).delay(2.0), value: headToHeadOpacity) // Add animation
                    }
                 */
                
                Spacer()
            }
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // Start the animation for text
                withAnimation {
                    welcomeTextOpacity = 1.0 // Fade in Welcome text
                }
                withAnimation {
                    titleTextOpacity = 1.0 // Fade in title text
                }
                withAnimation {
                    timedleOpacity = 1.0 // Fade in Timedle button
                }
                withAnimation {
                    infinidleOpacity = 1.0 // Fade in Infinidle button
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(DataModel())
    }
}
