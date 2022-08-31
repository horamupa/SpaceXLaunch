import SwiftUI



struct RoketView: View {
    
    @EnvironmentObject var viewModel: RoketViewModel
    var model: RoketModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: -20) {
                    
//                    AsyncImage(url: URL(string: "\(model.flickrImages[1])")) { image in
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
                    .cornerRadius(30)
                }
                .frame(height: screen.height)
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
        
    }
    
}


struct RoketView_Previews: PreviewProvider {
    
    static var viewModel = RoketViewModel()
    var model = RoketModel.share
    static var previews: some View {
        RoketView(model: RoketModel.share)
            .environmentObject(viewModel)
    }
        
}


struct Title: View {
    
    @State var name: String
    @EnvironmentObject var viewModel: RoketViewModel
    
    var body: some View {
        HStack {
            Text(name)
                .font(.custom("LabGrotesque-Medium", size: 24))
            Spacer()
            Button {
                viewModel.isPreference.toggle()
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
    
    var textUp: Int
    var textDown: String
    
    var body: some View {
        ZStack {
            Color.black
            RoundedRectangle(cornerRadius: 32)
                .fill(Color(#colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)))
                .frame(width: 96, height: 96)
                
            .overlay {
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
    }
}



struct HScroll: View {
    
    var model: RoketModel

    @EnvironmentObject var viewModel: RoketViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                HScrollInfo(textUp: viewModel.preferenceArray[0] ? Int(model.height.meters!) : Int(model.height.feet!), textDown: "Высота, \(viewModel.preferenceArray[0] ? "m" : "ft")")
                HScrollInfo(textUp: viewModel.preferenceArray[1] ? Int(model.diameter.meters!) : Int(model.diameter.feet!), textDown: "Диаметр, \(viewModel.preferenceArray[1] ? "m" : "ft")")
                HScrollInfo(textUp: viewModel.preferenceArray[2] ? model.mass.kg : model.mass.lb, textDown: "Масса, \(viewModel.preferenceArray[2] ? "kg" : "lb")")
                HScrollInfo(textUp: viewModel.preferenceArray[3] ? model.payloadWeights[0].kg : model.payloadWeights[0].lb , textDown: "Полезная нагрузка, \(viewModel.preferenceArray[3] ? "kg" : "lb")")
            }
            .background(.black)
            .padding()
        }
        .background(.black)
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
        .font(.custom("LabGrotesque-Regular", size: 16))
    }
    
    
}


struct MainInfo: View {
    
    @State var model: RoketModel
    var dateStr: Date { dateFormat() }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            HStack {
                Text("Первый запуск")
                Spacer()
                Text(dateStr, style: .date)
            }
            RegularInfoView(textLeft: "Страна", textRight: model.company)
            RegularInfoView(textLeft: "Стоимость запуска", textRight: String(model.costPerLaunch.formatted(.currency(code: "USD"))))
    
        }
        .font(.custom("LabGrotesque-Regular", size: 16))
        .padding(.horizontal, 20)
        
        Spacer()
        Spacer()
        
        VStack(alignment: .leading, spacing: 15) {
            Text("ПЕРВАЯ СТУПЕНЬ")
                .font(.custom("LabGrotesque-Bold", size: 16))
            RegularInfoView(textLeft: "Количество двигателей", textRight: "\(model.firstStage.engines)")
            HStack {
                Text("Количество топлива")
                Spacer()
                HStack {
                    Text("\(model.firstStage.fuelAmountTons.formatted())")
                    Text("ton")
                        .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)))
                }
                .font(.custom("LabGrotesque-Bold", size: 16))
            }
            HStack {
                Text("Время сгорания в секундах")
                Spacer()
                HStack {
                    Text("\(model.firstStage.burnTimeSEC ?? 100)")
                    Text("sec")
                        .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)))
                }
                .font(.custom("LabGrotesque-Bold", size: 16))
            }
        }
        .foregroundColor(.white)
        .font(.custom("LabGrotesque-Regular", size: 16))
        .padding(.horizontal, 20)
        Spacer()
        Spacer()
        
        VStack(alignment: .leading, spacing: 15) {
            Text("ВТОРАЯ СТУПЕНЬ")
                .font(.custom("LabGrotesque-Bold", size: 16))
            RegularInfoView(textLeft: "Количество двигателей", textRight: "\(model.secondStage.engines)")
            HStack {
                Text("Количество топлива")
                Spacer()
                HStack {
                    Text("\(model.secondStage.fuelAmountTons.formatted())")
                    Text("ton")
                        .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)))
                }
                .font(.custom("LabGrotesque-Bold", size: 16))
            }
            HStack {
                Text("Время сгорания в секундах")
                Spacer()
                HStack {
                    Text("\(model.secondStage.burnTimeSEC ?? 100)")
                    Text("sec")
                        .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)))
                }
                .font(.custom("LabGrotesque-Bold", size: 16))
            }
        }
        .foregroundColor(.white)
        .font(.custom("LabGrotesque-Regular", size: 16))
        .padding(.horizontal, 20)
    }
    
    func dateFormat() -> Date {
        let dateString = model.firstFlight
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let goodDate = dateFormatter.date(from: dateString) ?? Date.now
        return goodDate
    }
}
    



