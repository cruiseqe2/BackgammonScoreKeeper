//
//  NewMatchView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/03/2025.
//

import SwiftUI

struct NewMatchView: View {
    @Environment(ViewModel.self) var vm
    @Environment(\.dismiss) var dismiss
//    @Binding var actionOnReturn: ActionOnReturnFromNewGame
    @State private var menuBeingShown: Bool = false
    @State private var isConfigurePlayersShown: Bool = false
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemIndigo
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemYellow, .font: UIFont.systemFont(ofSize: 20)], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20)], for: .selected)
    }
    
    var body: some View {
        
        @Bindable var vm = vm
        
        VStack(spacing: 20) {
            
            HStack(alignment: .firstTextBaseline) {
                Text("BACKGAMMON")
                    .foregroundStyle(Color.theme.foreground)
                    .font(.system(size: 36, weight: .black))
                    .kerning(8)
                Text("Score Keeper")
                    .foregroundStyle(Color.theme.foreground)
                    .font(.system(size: 24, weight: .black))
                    .kerning(5)
                
                Spacer()
                
                HStack(spacing: 24) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 24))
                    }
                    .disabled(menuBeingShown)

                    Button {
                        vm.mainMenuShowing = false
                        vm.startGame()
                        dismiss()
                    } label: {
                        Text("Start")
                            .font(.system(size: 26))
                    }
                    .disabled(menuBeingShown)
                }
            }
            .padding(.top, 2)
            
            HStack {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("Current players - ")
                    Text(vm.ownerDisplayName)
                        .font(.system(size: 26, weight: .black))
                    Text(" **versus** ")
                    Text(vm.opponentDisplayName)
                        .font(.system(size: 26, weight: .black))
                }
                
                Spacer()
                
                Button {
                    isConfigurePlayersShown.toggle()
                } label: {
                    Text("")
                }
                .controlSize(.small)
                .buttonStyle(.xyz(isChange: vm.namesAreValid))
                .popover(isPresented: $isConfigurePlayersShown) {
                    ConfigureNamesView()
                        .padding(30)
                        .presentationCompactAdaptation(.popover)
                        .interactiveDismissDisabled()
                }
            }
            
            Group {
                Picker("", selection: $vm.typeOfMatch) {
                    Text("Social").tag(TypeOfMatch.social)
                    Text("Games").tag(TypeOfMatch.games)
                    Text("Points").tag(TypeOfMatch.points)
                }
                .pickerStyle(.segmented)
                .padding(.bottom, -20)
                
                
                GeometryReader { geo in
                    HStack(spacing: 0) {
                        SocialColumn()
                            .padding([.bottom, .leading, .trailing], 12)
                            .padding(.top, 8)
                            .frame(width: geo.size.width / 3, alignment: .leading)
                            .border(vm.typeOfMatch == .social ? .green : .clear, width: 1)
                        GamesColumn()
                            .padding([.bottom, .leading, .trailing], 12)
                            .padding(.top, 8)
                            .frame(width: geo.size.width / 3, alignment: .leading)
                            .border(vm.typeOfMatch == .games ? .green : .clear, width: 1)
                        PointsColumn()
                            .padding([.bottom, .leading, .trailing], 12)
                            .padding(.top, 8)
                            .frame(width: geo.size.width / 3, alignment: .leading)
                            .border(vm.typeOfMatch == .points ? .green : .clear, width: 1)
                    }
                }
                
                Spacer()
            }
            .opacity(vm.namesAreValid ? 1 : 0.25)
            .disabled(!vm.namesAreValid)
            
        }
    }
}

struct SocialColumn: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("No Doubling Cube")
            Divider()
            Text("Finish playing when 'STOP' is tapped")
            Divider()
            Text("Only Games are shown")
            
            Spacer()
        }
    }
}

struct GamesColumn: View {
    @Environment(ViewModel.self) var vm
    @State private var number: Int = 1
    var body: some View {
        @Bindable var vm = vm
        VStack(alignment: .leading) {
            Text("No Doubling Cube")
            Divider()
            Text("Points are hidden")
            Divider()
            Picker("", selection: $vm.finishWhen) {
                Text("Best Of").tag(FinishWhen .bestOf)
                Text("First To").tag(FinishWhen .firstTo)
            }
            .pickerStyle(.segmented)
            
            if vm.typeOfMatch == .games {
                NumberHorizontalPicker(selection: $vm.numberOfGamesOrPoints ?? 0, in: Array(1...50), validGamesOrPoints: vm.numbersToShow, numberToDisplay: 4)
                    .accentColor(.green)
            }
            
            Spacer()
        }
    }
}

struct PointsColumn: View {
    @Environment(ViewModel.self) var vm
    var body: some View {
        @Bindable var vm = vm
        VStack(alignment: .leading) {
            Toggle(isOn: $vm.useDoublingCube, label: {
                Text("Use Doubling Cube")
            })
            .toggleStyle(CheckboxStyle())
            .onChange(of: vm.useDoublingCube) { oldValue, newValue in
                vm.useDoublingCube = newValue
                vm.crawfordStatus = .preCrawford
            }
            Divider()
            Toggle(isOn: $vm.showGamesBoxIfPointsBased, label: {
                Text("Show Games Box")
            })
            .toggleStyle(CheckboxStyle())
            
            if vm.typeOfMatch == .points {
                HStack {
                    Text("First to: ")
                    NumberHorizontalPicker(selection: $vm.numberOfGamesOrPoints ?? 0, in: Array(1...50), validGamesOrPoints: .all, numberToDisplay: 3)
                        .accentColor(.green)
                }
            }
                      
            Spacer()
        }
    }
}


#Preview(traits: .landscapeLeft) {
    NewMatchView()
        .environment(ViewModel())
}
