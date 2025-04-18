//
//  NewMatchView.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 06/03/2025.
//

import SwiftUI

struct ConfigureMatchView: View {
    @Environment(ViewModel.self) var vm
    @Environment(\.dismiss) var dismiss
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemIndigo
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemYellow, .font: UIFont.systemFont(ofSize: 18)], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)], for: .selected)
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
                        vm.screenToShow = .none
                        vm.hideMatchViewAfterConfig = true
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 24))
                    }
                    .disabled(vm.isConfigurePlayersShown)
                    .opacity(vm.isConfigurePlayersShown ? 0 : 1)
                    
                    NewMatchButton(
                        buttonTitle: "Start",
                        bgColor: .green,
                        fgColor: .black,
                        isDisabled: vm.isConfigurePlayersShown || !vm.namesAreValid) {
                            vm.startMatch()
                            vm.hideMatchViewAfterConfig = false
                            vm.screenToShow = .match(config: false)
                            dismiss()
                        }
                        .frame(width: 100)
                        .opacity(vm.isConfigurePlayersShown || !vm.namesAreValid ? 0 : 1)
                }
            }
            .padding(.top, 2)
            
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
                    HStack(alignment: .top, spacing: 0) {
                        SocialColumn()
                            .padding([.bottom, .leading, .trailing], 12)
                            .padding(.top, 8)
                            .frame(width: geo.size.width / 3, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(vm.typeOfMatch == .social ? .indigo : .clear,
                                                  lineWidth: 1)
                            )
                        GamesColumn()
                            .padding([.bottom, .leading, .trailing], 12)
                            .padding(.top, 8)
                            .frame(width: geo.size.width / 3, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(vm.typeOfMatch == .games ? .indigo : .clear,
                                                  lineWidth: 1)
                            )
                        PointsColumn()
                            .padding([.bottom, .leading, .trailing], 12)
                            .padding(.top, 8)
                            .frame(width: geo.size.width / 3, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(vm.typeOfMatch == .points ? .indigo : .clear,
                                                  lineWidth: 1)
                            )
                    }
                    Spacer()
                }
            }
            .opacity((vm.isConfigurePlayersShown || !vm.namesAreValid) ? 0 : 1)
            .disabled(vm.isConfigurePlayersShown || !vm.namesAreValid)
            
        }
        .fullScreenCover(isPresented: $vm.isConfigurePlayersShown) {
            ConfigurePlayersView().applyBorder(borderType: .mint, radius: 20)
        }
    }
}

struct SocialColumn: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text("∙")
                Text("No Doubling Cube")
            }
            HStack(alignment: .top) {
                Text("∙")
                Text("Finish playing when 'Stop Social Game' is tapped on the main menu")
            }
            .environment(\._lineHeightMultiple, 0.85)
            HStack(alignment: .top) {
                Text("∙")
                Text("Only Games are shown")
            }
            Spacer()
        }
    }
}

struct GamesColumn: View {
    @Environment(ViewModel.self) var vm
    var body: some View {
        @Bindable var vm = vm
        VStack(alignment: .leading, spacing: 10) {
            Group {
                HStack(alignment: .top) {
                    Text("∙")
                    Text("No Doubling Cube")
                }
                HStack(alignment: .top) {
                    Text("∙")
                    Text("Points are hidden")
                }
                HStack(alignment: .top) {
                    Text("∙")
                    Text("No Gammons or Backgammons, only (single) wins")
                }
                if vm.typeOfMatch != .games {
                    HStack(alignment: .top) {
                        Text("∙")
                        Text("Choice of Best Of or First To")
                    }
                }
            }
            .environment(\._lineHeightMultiple, 0.85)
            .fixedSize(horizontal: false, vertical: true)
            
            if vm.typeOfMatch == .games {
                
                VStack(spacing: 0) {
                    
                    Picker("", selection: $vm.gamesFinishConditon) {
                        ForEach(GamesFinishCondition.allCases, id:\.self) { item in
                            Text("\(item.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Group {
                        if vm.typeOfMatch == .games {
                            if vm.finishWhen == .bestOf {
                                ChooseANumberView(
                                    numberOfGamesOrPoints: $vm.numberOfGamesOrPoints,
                                    strideBy: vm.strideBy,
                                    size: 31,
                                    show: 7
                                )
                            } else {   // .firstTo
                                ChooseANumberView(
                                    numberOfGamesOrPoints: $vm.numberOfGamesOrPoints,
                                    strideBy: vm.strideBy,
                                    size: 31,
                                    show: 7
                                )
                            }
                        }
                    }
                    .offset(y: 10)
                }
            }
            
            Spacer()
        }
    }
}

struct PointsColumn: View {
    @Environment(ViewModel.self) var vm
    var body: some View {
        @Bindable var vm = vm
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Use Doubling Cube?")
                Spacer()
                ToggleView(isOn: $vm.useDoublingCube, height: 35)
            }
            .onChange(of: vm.useDoublingCube) { oldValue, newValue in
                vm.useDoublingCube = newValue
                vm.crawfordStatus = .preCrawford
            }
            HStack {
                Text("Show Game Boxes?")
                Spacer()
                ToggleView(isOn: $vm.showSmallBoxIfPointsBased, height: 35)
            }
            
            Spacer()
                .frame(height: 1)
            
            if vm.typeOfMatch == .points {
                VStack {
                    HStack(spacing: 0) {
                        Text("First to: ")
                        Spacer()
                        
                        if vm.typeOfMatch == .points {
                            ChooseANumberView(
                                numberOfGamesOrPoints: $vm.numberOfGamesOrPoints,
                                strideBy: vm.strideBy,
                                size: 31,
                                show: 5
                            )
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}

#Preview(traits: .landscapeLeft) {
    ConfigureMatchView()
        .environment(ViewModel())
}

