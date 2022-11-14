//
//  ToggleView.swift
//  SpaceXLaunch
//
//  Created by MM on 14.11.2022.
//

import SwiftUI

struct MetrFootStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(.labGrotesque(.regular, size: 16))
            Spacer()
            Rectangle()
                .fill(Color(#colorLiteral(red: 0.12941177189350128, green: 0.12941177189350128, blue: 0.12941177189350128, alpha: 1)))
                .frame(width: 115, height: 40, alignment: .center)
                .overlay(
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(1)
                        .shadow(radius: 2)
                        .overlay(
                            Text(configuration.isOn ? "ft" : "m")
                                .font(.labGrotesque(.bold, size: 16))
                                .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)))
                        )
                        .frame(width: 56, height: 40)
                        .offset(x: configuration.isOn ? 30 : -30, y: 0)
                        .animation(Animation.linear(duration: 0.1))
                        
                )
                .cornerRadius(8)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

struct KgLbStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(.labGrotesque(.regular, size: 16))
            Spacer()
            Rectangle()
                .fill(Color(#colorLiteral(red: 0.12941177189350128, green: 0.12941177189350128, blue: 0.12941177189350128, alpha: 1)))
                .frame(width: 115, height: 40, alignment: .center)
                .overlay(
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(1)
                        .shadow(radius: 2)
                        .overlay(
                            Text(configuration.isOn ? "lb" : "kg")
                                .font(.labGrotesque(.bold, size: 16))
                                .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)))
                        )
                        .frame(width: 56, height: 40)
                        .offset(x: configuration.isOn ? 30 : -30, y: 0)
                        .animation(Animation.linear(duration: 0.1))
                        
                )
                .cornerRadius(8)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

struct ToggleView: View {
    
    @State var isToggle: Bool = false
    
    var body: some View {
        
        Toggle(isOn: $isToggle, label: {
            Text("Active")
        })
        .padding()
        .toggleStyle(MetrFootStyle())
    }
    
    struct MetrFootStyle: ToggleStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                configuration.label
                Spacer()
                Rectangle()
                    .foregroundColor(Color(#colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)))
                    .frame(width: 115, height: 40, alignment: .center)
                    .overlay(
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(1)
                            .overlay(
                                Text(configuration.isOn ? "m" : "ft")
                                    .font(.labGrotesque(.bold, size: 16))
                                    .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)))
                            )
                            .frame(width: 56, height: 40)
                            .offset(x: configuration.isOn ? 30 : -30, y: 0)
                            .animation(Animation.linear(duration: 0.1))
                            
                    )
                    .cornerRadius(8)
                    .onTapGesture { configuration.isOn.toggle() }
            }
        }
        
    }
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView()
    }
}
