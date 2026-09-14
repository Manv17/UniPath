//
//  WelcomeView.swift
//  UniPath
//
//  Created by Manveer Singh on 14/09/2026.
//

import SwiftUI

struct WelcomeView: View {

    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: 0) {

            Spacer()

            Image("AppIconSet")
                .resizable()
                .scaledToFit()
                .frame(width: 132, height: 132)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 28,
                        style: .continuous
                    )
                )
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 18,
                    y: 8
                )

            VStack(spacing: 12) {
                Text("UniPath")
                    .font(.system(
                        size: 40,
                        weight: .bold,
                        design: .rounded
                    ))

                Text("La tua carriera universitaria,\nsempre sotto controllo.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }
            .padding(.top, 32)
            
            Text("Media, CFU, esami e progressi in un unico posto.")
                .font(.footnote)
                .foregroundStyle(.tertiary)
                .multilineTextAlignment(.center)
                .padding(.top, 14)

            Spacer()

            Button {
                onContinue()
            } label: {
                Text("Continua")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
            }
            .buttonStyle(.glassProminent)
            
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }
}

#Preview {
    WelcomeView {
        print("Continue")
    }
}
