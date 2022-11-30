import SwiftUI



struct RocketView: View {
    
    @EnvironmentObject var viewModel: RocketViewModel
    @State var isLaunch: Bool = false
    var model: RocketModel
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    
                    rocketImage
                    
                    VStack {
                       
                        Title(name: model.name)
 
                        HScroll(model: model)
                        
                        MainInfo(model: model)
                        
                        NavigationLink {
                            LaunchScreenView(model: model)
                                .environmentObject(viewModel)
                        } label: {
                            Text("Посмотреть запуски")
                                .font(.labGrotesque(.medium, size: 20))
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color(#colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)))
                                .cornerRadius(10)
                                .padding()
                                .padding(.horizontal)
                        }
                    }
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(32)
                    .offset(y: -50)
                }
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
    }
}


struct RoketView_Previews: PreviewProvider {
    
    static var viewModel = RocketViewModel()
    var model = RocketModel.share
    static var previews: some View {
        RocketView(model: RocketModel.share)
            .environmentObject(viewModel)
    }
        
}

extension RocketView {
    private var rocketImage: some View {
        ZStack {
            if (model.flickrImages.first != nil) {
                DownloadImageView(url: model.flickrImages.first!)
                    .scaledToFill()
                    .frame(minHeight: 320)
            } else {
                ZStack {
                    Image("Union")
                        .resizable()
                        .padding()
                        .frame(width: 150, height: 150)
                    Text("Image loading...")
                        .foregroundColor(.white)
                        .font(.labGrotesque(.regular, size: 16))
                }
            }
        }
    }
}


struct Title: View {
    
    @State var name: String
    @EnvironmentObject var viewModel: RocketViewModel
    
    var body: some View {
        HStack {
            Text(name)
                .font(.labGrotesque(.medium, size: 28))
            Spacer()
            Button {
                viewModel.isPreference.toggle()
            } label: {
                Image("Setting")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 20)
    }
}


struct HScrollGeneric: View {
    
    var preference: Bool = true
    var model: RocketModel
    var whatToShow: Int
    
    init(preference: Bool, model: RocketModel, whatToShow: Int) {
        self.preference = preference
        self.model = model
        self.whatToShow = whatToShow
    }
    
    var body: some View {
        ZStack {
            Color.black
            RoundedRectangle(cornerRadius: 32)
                .fill(Color(#colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)))
                .frame(width: 96, height: 96)
            .overlay {
                if whatToShow == 0 {
                    HScrollInfo(
                        textUp: preference ? model.height.feet.formatter1dec() : model.height.meters.formatter1dec(),
                        textDown: "Высота, \(preference ? "ft" : "m")")
                }
                if whatToShow == 1 {
                    HScrollInfo(
                        textUp: preference ?
                        model.diameter.feet.formatter1dec() :
                            model.diameter.meters.formatter1dec(),
                        textDown: "Диаметр, \(preference ? "ft" : "m")")
                }
                if whatToShow == 2 {
                    HScrollInfo(
                        textUp: preference ?
                        model.mass.lb.formatter3dec() :
                            model.mass.kg.formatter3dec(),
                        textDown: "Масса, \(preference ? "lb" : "kg")")
                }
                else if whatToShow == 3 {
                    HScrollInfo(
                        textUp: preference ?
                        model.payloadWeights[0].lb.formatter3dec() :
                            model.payloadWeights[0].kg.formatter3dec() ,
                        textDown: "Нагрузка, \(preference ? "lb" : "kg")")
                }
                
            }
            
        }
    }
}

struct HScrollInfo: View {
    
    var textUp: String
    var textDown: String
    
    var body: some View {
                VStack(spacing: 5) {
                    Text("\(textUp)")
                        .font(.custom("LabGrotesque-Bold", size: 16))
                        .foregroundColor(Color(.white))
                        .lineSpacing(16)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("\(textDown)")
                            .font(.custom("LabGrotesque-Regular", size: 14))
                            .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)))
                            .multilineTextAlignment(.center)
                    }
                }
    }
}



struct HScroll: View {
    
    var model: RocketModel

    @EnvironmentObject var viewModel: RocketViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<4) { item in
                    HScrollGeneric(preference: viewModel.preferenceArray[item], model: model, whatToShow: item)
                }
            }
            .background(.black)
            .padding()
        }
        .background(.black)
    }
}

struct RegularInfoView<Content:View>: View {
    
    var text: String
    var content: Content
    
    init(text: String, @ViewBuilder content: () -> Content) {
        self.text = text
        self.content = content()
    }
    
    var body: some View {
        
        HStack {
            Text(text)
            Spacer()
            content
        }
        .font(.custom("LabGrotesque-Regular", size: 16))
    }
    
    
}

struct MainInfo: View {
    
    @State var model: RocketModel
//    var dateStr: Date { dateFormat() }
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 16) {
                RegularInfoView(text: "Первый запуск") {
                    Text(dateFormat())
                }
                RegularInfoView(text: "Страна") {
                    Text(model.country)
                }
                RegularInfoView(text: "Стоимость запуска") {
                    Text(String(model.costPerLaunch.formatUsingAbbrevation()))
                }
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text("ПЕРВАЯ СТУПЕНЬ")
                    .font(.custom("LabGrotesque-Bold", size: 16))
                RegularInfoView(text: "Количество двигателей") {
                    Text("\(model.firstStage.engines)")
                }
                RegularInfoView(text: "Количество топлива") {
                    HStack {
                        Text("\(model.firstStage.fuelAmountTons.formatted())")
                        Text("ton")
                            .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)))
                    }
                }
                RegularInfoView(text: "Время сгорания в секундах") {
                    HStack {
                        Text("\(model.firstStage.burnTimeSEC ?? 100)")
                        Text("sec")
                            .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)))
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text("ВТОРАЯ СТУПЕНЬ")
                    .font(.custom("LabGrotesque-Bold", size: 16))
                RegularInfoView(text: "Количество двигателей") {
                    Text("\(model.secondStage.engines)")
                }
                RegularInfoView(text: "Количество топлива") {
                    HStack {
                        Text("\(model.secondStage.fuelAmountTons.formatted())")
                        Text("ton")
                            .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)))
                    }
                }
                RegularInfoView(text: "Время сгорания в секундах") {
                    HStack {
                        Text("\(model.secondStage.burnTimeSEC ?? 100)")
                        Text("sec")
                            .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)))
                    }
                }
            }
            .foregroundColor(.white)
            .font(.custom("LabGrotesque-Regular", size: 16))
        }
        .padding(.horizontal, 20)
    }
    
    func dateFormat() -> String {
        let dateString = model.firstFlight
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let goodDate = dateFormatter.date(from: dateString) ?? Date.now
        return goodDate.formatted(.dateTime.day().month(.wide).year())
    }
}
