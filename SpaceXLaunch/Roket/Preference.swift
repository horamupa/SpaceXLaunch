//
//  Preference.swift
//  SpaceXLaunch
//
//  Created by MM on 25.08.2022.
//

import SwiftUI

struct Preference: View {
    
//    @EnvironmentObject var viewModel: RoketViewModel
    
    @ObservedObject var viewModel: RoketViewModel
    
    @State var togglee: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Toggle(isOn: $viewModel.isMetricHeight) {
                                Text("Высота")
                            }
                    .toggleStyle(.switch)
                            .padding()
                    Toggle(isOn: $viewModel.isMetricDiametr) {
                                Text("Диаметр")
                            }
                            .toggleStyle(SwitchToggleStyle())
                            .padding()
                    Toggle(isOn: $viewModel.isMetricMass) {
                                Text("Масса")
                            }
                            .toggleStyle(SwitchToggleStyle())
                            .padding()
                    Toggle(isOn: $viewModel.isMetricUsefulWeight) {
                                Text("Полезная нагрузка")
                            }
                            .toggleStyle(SwitchToggleStyle())
                            .padding()
                    Spacer()
                }
                .foregroundColor(.white)
            }
            .onAppear {
                UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
            }
            .navigationTitle("Настройки")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.white)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.isPreference.toggle()
                    } label: {
                        Text("Закрыть")
                            .foregroundColor(.white)
                    }
                }
                

            }
        }
        
    }
    
}

struct Preference_Previews: PreviewProvider {
    
    @EnvironmentObject var viewModel: RoketViewModel
    
    static var previews: some View {
        Preference(viewModel: RoketViewModel())
    }
}
