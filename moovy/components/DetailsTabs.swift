
import Foundation
import SwiftUI

public struct DetailsTabs<Content>: View where Content : View
{
    var tabs: [String]
    @Binding var selectedTab: Int
    @ViewBuilder var content: () -> Content

    var backgroundColor: Color
    var contentColor: Color
    var textColor: Color
    var activeTextColor: Color
    var barIndicatorColor: Color
    var textSize: CGFloat
    var padding: CGFloat
    var heightOfContent: CGFloat


    public init(tabs: [String],
                selectedTab: Binding<Int>,
                @ViewBuilder content: @escaping () -> Content,
                backgroundColor: Color = .white,
                contentColor: Color = .white,
                textColor: Color = .black.opacity(0.4),
                activeTextColor: Color = .black.opacity(0.8),
                barIndicatorColor: Color = .blue.opacity(0.7),
                heightOfContent: CGFloat = 100,
                textSize: CGFloat = 16,
                padding: CGFloat = 15)
    {
        self.tabs = tabs;
        self._selectedTab = selectedTab;
        self.content = content;
        self.backgroundColor = backgroundColor;
        self.contentColor = contentColor;
        self.textColor = textColor;
        self.activeTextColor = activeTextColor;
        self.barIndicatorColor = barIndicatorColor;
        self.textSize = textSize;
        self.padding = padding;
        self.heightOfContent = heightOfContent;
    }


    public var body: some View
    {
        return VStack (spacing: 1)
        {
            // TABS | TITLE
                ScrollViewReader { proxy in
                    HStack(spacing: 0) {
                        Spacer()
                        ForEach(0 ..< tabs.count, id: \.self) { row in
                            Button(action: {
                                withAnimation {
                                    selectedTab = row
                                }
                            }, label: {
                                VStack(spacing: 0) {
                                    HStack {
                                        // Text
                                        Text(tabs[row])
                                            .font(Font.system(size: textSize, weight: .semibold))
                                            .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 15))
                                    }
                                    .padding(.horizontal, padding)
                                    .foregroundColor(selectedTab == row ? activeTextColor : textColor)

                                    // Bar Indicator
                                    RoundedRectangle(cornerRadius: 2)
                                        .fill(barIndicatorColor)
                                        .frame(height: 3.0)
                                        .scaleEffect(x: selectedTab == row ? 1 : 0,
                                                     y: 1, anchor: .center)
                                        .offset(x: 0, y: -0.5)
                                }
                            })
                            .buttonStyle(PlainButtonStyle())
                        }
                        Spacer()
                    }
                    .onChange(of: selectedTab){ oldState, newState in
                        withAnimation {
                            proxy.scrollTo(newState)
                        }
                    }
                }
            .background(backgroundColor)
            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: -0.5)

            // TABS | CONTENT
            TabView(selection: $selectedTab.animation(),
                    content: self.content)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: heightOfContent)
        }
        .background(contentColor)
    }
}

struct DetailsTabs_Previews: PreviewProvider {
    static var previews: some View {

        Tabs(tabs:  ["Music", "Movies", "Books", "Games"],
             selectedTab: .constant(0),
             content: {
                Text("Music").font(.system(size: 15)).foregroundColor(.black).tag(0)
                Text("Movies").tag(1)
                Text("Books").tag(2)
                Text("Games").tag(3)
             },
             backgroundColor: .white,
             contentColor: .white,
             textColor: .black.opacity(0.4),
             activeTextColor: .black.opacity(0.8),
             barIndicatorColor: .blue.opacity(0.7),
             heightOfContent: 300,
             textSize: 16,
             padding: 15)
    }
}
