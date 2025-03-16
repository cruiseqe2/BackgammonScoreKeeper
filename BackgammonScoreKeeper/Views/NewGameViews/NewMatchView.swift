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
                
                HStack(spacing: 25) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 24))
                    }
                    .disabled(vm.isConfigurePlayersShown)
                    .opacity(vm.isConfigurePlayersShown ? 0.25 : 1)
                    
                    NewMatchButton(
                        buttonTitle: "Start",
                        bgColor: .green,
                        fgColor: .black,
                        isDisabled: vm.isConfigurePlayersShown || !vm.namesAreValid) {
                            vm.mainMenuShowing = false
                            vm.startGame()
                            //                            dismiss()
                        }
                        .frame(width: 100)
                        .opacity(vm.isConfigurePlayersShown || !vm.namesAreValid ? 0.30 : 1)
                }
            }
            .padding(.top, 2)
            .opacity(vm.isConfigurePlayersShown ? 0.15 : 1)
            
            HStack {
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("Current players: ")
                    Text(vm.ownerDisplayName)
                        .font(.system(size: 26, weight: .black))
                    Text(" **versus** ")
                    Text(vm.opponentDisplayName)
                        .font(.system(size: 26, weight: .black))
                }
                .opacity(vm.isConfigurePlayersShown ? 0 : 1)
                
                Spacer()
                
                Button {
                    vm.isConfigurePlayersShown.toggle()
                } label: {
                    Text("")
                }
                .controlSize(.small)
                .buttonStyle(.configureChangeButton(isChange: vm.namesAreValid))
                .opacity(vm.isConfigurePlayersShown ? 0 : 1)
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
            
            .opacity((vm.isConfigurePlayersShown || !vm.namesAreValid) ? 0.1 : 1)
            .disabled(vm.isConfigurePlayersShown || !vm.namesAreValid)
            
        }
        .overlay(vm.isConfigurePlayersShown ? ConfigurePlayersView().mintBorder() : nil)
            
//            .opacity(vm.namesAreValid ? 1 : 0.25)
//            .disabled(!vm.namesAreValid)
            
        }
    }
    


struct SocialColumn: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("No Doubling Cube")
            Divider()
            Text("Finish playing when 'Stop Social Game' is tapped on the main menu")
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
            
//            if vm.typeOfMatch == .games {
                NumberHorizontalPicker(selection: $vm.numberOfGamesOrPoints ?? 0, in: Array(1...50), validGamesOrPoints: vm.numbersToShow, numberToDisplay: 5)
                    .accentColor(.green)
                    .opacity(vm.typeOfMatch == .games ? 1 : 0)
//            }
            
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
                Text("Show Game Boxes")
            })
            .toggleStyle(CheckboxStyle())
            
            if vm.typeOfMatch == .points {
                HStack {
                    Text("First to: ")
                    NumberHorizontalPicker(selection: $vm.numberOfGamesOrPoints ?? 0, in: Array(1...50), validGamesOrPoints: .all, numberToDisplay: 4)
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

