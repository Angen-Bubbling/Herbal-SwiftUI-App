
import SwiftUI

struct CustomPicker: View {
    @Binding var choosenCategory: ProductListEndpoint
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack {
                        HStack {
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Text(choosenCategory.rawValue)
                        .bold()
                        .font(.headline)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 8)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(25)
                }
                .padding(.trailing, 8)
                
                Button(action: {
                    withAnimation() {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                        .cornerRadius(100)
                        .padding()
                        .animation(.spring(), value: isExpanded)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.secondaryBackground)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 2, x: 0.0, y: 2)
            
            if isExpanded {
                VStack(spacing: 10) {
                                        ForEach(ProductListEndpoint.allCases, id: \.self) { category in
                        Button(action: {
                            withAnimation(.spring()) {
                                choosenCategory = category
                                isExpanded = false                             }
                        }) {
                            Text(category.rawValue)
                                .bold()
                                .font(.headline)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                                .background(choosenCategory == category ? Color.accentColor : Color.secondaryBackground)
                                .foregroundColor(choosenCategory == category ? .white : .accentColor)
                                .cornerRadius(25)
                        }
                        .frame(height: 40)
                    }
                }
                .padding()
                .background(Color.secondaryBackground)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 0.0, y: 2)
                //.transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
                .transition(.slideAndOpacity)
            }
        }
        .padding()
    }
}


struct SlideAndOpacityModifier: ViewModifier {
    var offset: CGFloat
    var opacity: Double

    func body(content: Content) -> some View {
        content
            .offset(y: offset)
            .opacity(opacity)
    }
}

extension AnyTransition {
    static var slideAndOpacity: AnyTransition {
        AnyTransition.modifier(
            active: SlideAndOpacityModifier(offset: -50, opacity: 0.0),
            identity: SlideAndOpacityModifier(offset: 0, opacity: 1.0)
        )
    }
}


struct CustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomPicker(choosenCategory: .constant(.all))
    }
}
