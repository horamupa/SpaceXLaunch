import SwiftUI



struct RoketView: View {
    

    @State var model: RoketModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: -20) {
                    
//                    AsyncImage(url: URL(string: viewModel.isFetched ? "\(viewModel.roketArray[0].flickrImages[0])" : "https://hws.dev/img/logo.png")) { image in
//                                image.resizable().scaledToFit()
//                            }
//                                placeholder: {
//                                    ProgressView()
//                                }
//                            .frame(width: 200, height: 200)
                    
                    Image("SpaceX1")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    VStack {
                        Title(name: model.name)
                        
                        HScroll(model: model)
                        
                        
                        MainInfo(model: model)
                        
                        NavigationLink {
                            
                            LaunchScreenView()
                            
                        } label: {
                            Text("Посмотреть запуски")
                                .padding()
                                .frame(width: 200, height: 50)
                                .background(.thinMaterial)
                                .cornerRadius(10)
                        }
                        
                        Text(" ")
                            .frame(height: 50)
                    }
                    .foregroundColor(.white)
                    .frame(width: screen.width)
                    .background(.black)
                    .cornerRadius(20)
                }
                .frame(height: screen.height)
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
        
    }
    
}


struct RoketView_Previews: PreviewProvider {
    static var previews: some View {
        RoketView(model: RoketModel.share)
    }
}


struct Title: View {
    
    @State var name: String
    
    var body: some View {
        HStack {
            Text(name)
                .bold()
            Spacer()
            Button {
                print("go settings")
            } label: {
                Image(systemName: "gearshape")
            }
        }
        .padding()
        .padding()
        .font(.system(size: 30))
        .font(.headline)
    }
}




struct HScrollInfo: View {
    
    @State var textUp: Int
    @State var textDown: String
    @State var inMetric: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text("\(textUp)")
                .bold()
            HStack {
                Text(textDown)
                    .foregroundColor(.secondary)
                Text(inMetric)
            }
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(35)
    }
}



struct HScroll: View {
    
    @State var model: RoketModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                HScrollInfo(textUp: Int(model.height.meters!), textDown: "Высота", inMetric: "met")
                HScrollInfo(textUp: Int(model.diameter.meters!), textDown: "Диаметр", inMetric: "met")
                HScrollInfo(textUp: model.mass.kg, textDown: "Масса", inMetric: "kg")
                HScrollInfo(textUp: model.payloadWeights[0].kg , textDown: "Полезная нагрузка", inMetric: "met")
            }
            .padding()
        }
        .frame(minHeight: 100)
    }
}

struct RegularInfoView: View {
    
    @State var textLeft: String
    @State var textRight: String
    
    var body: some View {
        
        HStack {
            Text(textLeft)
            Spacer()
            Text(textRight)
        }
    }
    
    
}


struct MainInfo: View {
    
    @State var model: RoketModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            RegularInfoView(textLeft: "Первый запуск", textRight: model.firstFlight)
            RegularInfoView(textLeft: "Страна", textRight: model.company)
            RegularInfoView(textLeft: "Стоимость запуска", textRight: String(model.costPerLaunch))
    
        }
        .padding(.horizontal, 20)
        
        Spacer()
        Spacer()
        VStack(alignment: .leading, spacing: 15) {
            Text("ПЕРВАЯ СТУПЕНЬ")
                .bold()
            RegularInfoView(textLeft: "Количество двигателей", textRight: "\(model.firstStage.engines)")
            RegularInfoView(textLeft: "Количество топлива", textRight: "\(model.firstStage.fuelAmountTons) ton")
            RegularInfoView(textLeft: "Время сгорания в секундах", textRight: "\(model.firstStage.burnTimeSEC ?? 100)")
        
        }
        .padding(.horizontal, 20)
        Spacer()
        Spacer()
        VStack(alignment: .leading, spacing: 15) {
            Text("ВТОРАЯ СТУПЕНЬ")
                .bold()
            RegularInfoView(textLeft: "Количество двигателей", textRight: "\(model.secondStage.engines)")
            RegularInfoView(textLeft: "Количество топлива", textRight: "\(model.secondStage.fuelAmountTons) ton")
//            RegularInfoView(textLeft: "Время сгорания в секундах", textRight: "go")
//            RegularInfoView(textLeft: "Время сгорания в секундах", textRight: "\(model.secondStage.burnTimeSEC)")
        }
        .padding(.horizontal, 20)
    }
}



