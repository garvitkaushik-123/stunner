import SwiftUI

struct SwipeToBuyButton: View {
    var action: () -> Void
    @State private var offsetX: CGFloat = 0
    @State private var isComplete = false
    let circleSize: CGFloat = 44
    let padding: CGFloat = 4

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let dragLimit = totalWidth - circleSize - padding * 2

            ZStack {
                // Background rectangle
                RoundedRectangle(cornerRadius: 25)
                    .fill(isComplete ? Color.green : Color.black)
                    .frame(height: 50)
                
                // Text centered in available space (one line)
                Text(isComplete ? "" : "SWIPE TO ADD")
                    .font(.visbySemibold(size: 15))
                    .tracking(0.3 * 15)
                    .foregroundColor(.stunner)
                    .fixedSize()
                    .frame(maxWidth: .infinity)
                    .padding(.leading, circleSize + padding * 2)
                
                HStack {
                    Circle()
                        .fill(Color.stunner)
                        .frame(width: circleSize, height: circleSize)
                        .overlay(
                            Image(systemName: isComplete ? "checkmark" : "chevron.right")
                                .foregroundColor(isComplete ? .green : .black)
                                .font(.system(size: 22, weight: .bold))
                        )
                        .offset(x: offsetX)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if !isComplete {
                                        offsetX = max(0, min(value.translation.width, dragLimit))
                                    }
                                }
                                .onEnded { _ in
                                    if offsetX >= dragLimit {
                                        withAnimation(.spring()) {
                                            offsetX = dragLimit
                                            isComplete = true
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            action()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                    withAnimation {
                                                        offsetX = 0
                                                        isComplete = false
                                                    }
                                                }
                                        }
                                    } else {
                                        withAnimation {
                                            offsetX = 0
                                        }
                                    }
                                }
                        )
                    Spacer()
                }
                .padding(.leading, padding)
            }
            .frame(height: 50)
        }
        .frame(height: 50)
    }
}
