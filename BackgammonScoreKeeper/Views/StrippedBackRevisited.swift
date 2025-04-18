
import SwiftUI

enum TGamesOrPoints: String, RawRepresentable, CaseIterable {
    case games = "Games (Stride can be 1 or 2)"
    case points = "Points (Stride is always 1)"
}

enum TTypeOfPlay: String, RawRepresentable, CaseIterable {
    case bestOf = "Best Of (2)"
    case firstTo = "First To (1)"
}

@Observable
class TestViewModel {
    var numberOfGames: Int = 15
    var gamesOrPoints: TGamesOrPoints = .games
    var typeOfPlay: TTypeOfPlay = .bestOf
    var strideBy: Int {
        gamesOrPoints == .points ? 1 :
        typeOfPlay == .firstTo ? 1 : 2
    }
    var numbersToShow: [Int] {
        Array(stride(from: 1, through: 100, by: strideBy))
    }
}

struct StrippedBack: View {
    @Environment(\.testViewModel) var tvm

    var body: some View {

        @Bindable var tvm = tvm

        VStack(spacing: 20) {

            HStack(spacing: 40) {
                Text("Current tvm.numberOfGames: \(tvm.numberOfGames)")
                Text("Current tvm.stride: \(tvm.strideBy)")
            }

            Picker("", selection: $tvm.gamesOrPoints) {
                ForEach(TGamesOrPoints.allCases, id:\.self) { item in
                    Text("\(item.rawValue)")
                }
            }
            .pickerStyle(.segmented)

            HStack(spacing: 0) {

                VStack(spacing: 20) {
                    Text("Games")
                        .frame(maxWidth: .infinity)

                    Picker("", selection: $tvm.typeOfPlay) {
                        ForEach(TTypeOfPlay.allCases, id:\.self) { item in
                            Text("\(item.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                    TChooseNumber(numberOfGames: $tvm.numberOfGames,
                                  numbersToShow: tvm.numbersToShow, strideBy: tvm.strideBy)
                    Spacer()
                }
                .border(Color.blue)
                .frame(height: 200)

                VStack(spacing: 20) {
                    Text("Points")
                        .frame(maxWidth: .infinity)
                    Text("Can only be First To therefore stride is always 1")
                    TChooseNumber(numberOfGames: $tvm.numberOfGames, numbersToShow: tvm.numbersToShow, strideBy: tvm.strideBy)
                    Spacer()
                }
                .border(Color.green)
                .frame(height: 200)
            }
        }
    }
}

struct TChooseNumber: View {

    @Binding var numberOfGames: Int
    let numbersToShow: [Int]
    let strideBy: Int

    @State var numberToShow: Int? = nil
//    var allNumbers: [Int] = Array(stride(from: 1, through: 100, by: 1))
//    var oddNumbers: [Int] = Array(stride(from: 1, through: 100, by: 2))
//    @State var numbersToShow = [Int]()

//    init(
////        boundNumer: Binding<Int>? = nil,
//        numberToShow: Int? = nil,
//        strideBy: Int,
////        allNumbers: [Int],
////        oddNumbers: [Int],
////        numbersToShow: [Int] = [Int]()
//    ) {
////        self.boundNumer = boundNumer
//        self.numberToShow = numberToShow
//        self.strideBy = strideBy
////        self.numbersToShow = strideBy == 1 ? allNumbers : oddNumbers
////        print(self.numbersToShow)
//    }

    var body: some View {

        VStack {
            HStack(spacing: 50) {
                Text("Number To Show: \(numberToShow ?? 0)")
                Button("Press Me") {
                    numberToShow = (1..<100).randomElement()
                    if strideBy == 2 && numberToShow! % 2 == 0 {
                        numberToShow! += 1
                    }
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 3) {
                    ForEach(numbersToShow, id:\.self) { index in
                        Text("\(index)")
                            .frame(width: 30, height: 30)
                            .id(index)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $numberToShow, anchor: .center)
            .frame(maxWidth: 300)
        }
        .onChange(of: numberToShow ?? 73) { _, newValue in
            numberOfGames = newValue
        }
        .onChange(of: strideBy) { _, newValue in
            print("strideBy changed to \(newValue)")
        }
        .onAppear {
            numberToShow = numberOfGames
//            numbersToShow = strideBy == 1 ? allNumbers : oddNumbers

            if strideBy == 2 && numberToShow! % 2 == 0 {
                numberToShow! += 1
            }
            if numberToShow! > 99 {
                numberToShow! = 99
            }

            print(self.numbersToShow)
        }

    }

}

extension EnvironmentValues {
    @Entry var testViewModel = TestViewModel()
}

#Preview(traits: .landscapeLeft) {
    @Previewable @State var testViewModel = TestViewModel()
    StrippedBack()
        .environment(TestViewModel())
}
