import SwiftUI

extension Color {
    static let backGroundColors = [Color.red, Color.blue, Color.green, Color.orange, Color.pink, Color.purple, Color.yellow]
    
    static var background: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .purple, .white]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}

struct MainButtonModifier: ViewModifier {
    var scaleAmount: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 40)
            .padding(.vertical, 25)
            .background(Color.green)
            .cornerRadius(25)
            .foregroundColor(.black)
            .font(.title)
            .overlay(RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.black, lineWidth: 4))
            .shadow(color: .black, radius: 25)
            .scaleEffect(scaleAmount)
    }
}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle
                    .weight(.semibold))
            .shadow(color: .black, radius: 20)
            .lineLimit(nil)
            .multilineTextAlignment(.center)
    }
}

extension View {
    func titleModifier() -> some View {
        self.modifier(TitleModifier())
    }
    
    func mainButtonModifier(scaleAmount: CGFloat) -> some View {
        self.modifier(MainButtonModifier(scaleAmount: scaleAmount))
    }
}
