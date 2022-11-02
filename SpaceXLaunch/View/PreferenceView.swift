//
//  Preference.swift
//  SpaceXLaunch
//
//  Created by MM on 25.08.2022.
//

import SwiftUI

struct Preference: View {
    
    @ObservedObject var viewModel: RocketViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Toggle(isOn: $viewModel.preferenceArray[0]) {
                        Text(viewModel.preferenceArray[0] ? "Высота (m)" : "Высота (ft)")
                            }
                    .toggleStyle(.switch)
                            .padding()
                    Toggle(isOn: $viewModel.preferenceArray[1]) {
                        Text(viewModel.preferenceArray[1] ? "Диаметр (m)" : "Диаметр (ft)")
                            }
                            .toggleStyle(SwitchToggleStyle())
                            .padding()
                    Toggle(isOn: $viewModel.preferenceArray[2]) {
                        Text(viewModel.preferenceArray[2] ? "Масса (kg)" : "Масса (lb)")
                            }
                            .toggleStyle(SwitchToggleStyle())
                            .padding()
                    Toggle(isOn: $viewModel.preferenceArray[3]) {
                        Text(viewModel.preferenceArray[3] ? "Полезная нагрузка (kg)" : "Полезная нагрузка (lb)")
                            }
                            .toggleStyle(SwitchToggleStyle())
                            .padding()
                    Spacer()
                }
                .font(.labGrotesque(.regular, size: 18))
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
            .onDisappear {
                viewModel.savePreference()
            }
        }
        
    }
    
}

struct Preference_Previews: PreviewProvider {
    
    @EnvironmentObject var viewModel: RocketViewModel
    
    static var previews: some View {
        Preference(viewModel: RocketViewModel())
    }
}

