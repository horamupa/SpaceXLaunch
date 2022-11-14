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
                
                VStack(spacing: 25) {
                
                    Toggle(isOn: $viewModel.preferenceArray[0], label: {
                        Text("Высота")
                    })
                    .toggleStyle(MetrFootStyle())
                    
                    Toggle(isOn: $viewModel.preferenceArray[1], label: {
                        Text("Диаметр")
                    })
                    .toggleStyle(MetrFootStyle())
                    
                    Toggle(isOn: $viewModel.preferenceArray[2], label: {
                        Text("Масса")
                    })
                    .toggleStyle(KgLbStyle())
                   
                    Toggle(isOn: $viewModel.preferenceArray[3], label: {
                        Text("Полезная нагрузка")
                    })
                    .toggleStyle(KgLbStyle())
                    
                    Spacer()
                }
                .padding(40)
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

