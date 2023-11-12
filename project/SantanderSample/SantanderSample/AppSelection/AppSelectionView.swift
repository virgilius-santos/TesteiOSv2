import SwiftUI

protocol AppSelectionRouting {
    func showBakingWithUIKit()
    func showBakingWithSwiftUI()
}

struct AppSelectionView: View {
    let routing: AppSelectionRouting
    
    var body: some View {
        List {
            Text("Banking With UIKit")
                .onTapGesture {
                    routing.showBakingWithUIKit()
                }
            Text("Banking With SwiftUI")
                .onTapGesture {
                    
                }
        }
    }
}

struct AppSelectionView_Previews: PreviewProvider {
    struct Mock: AppSelectionRouting {
        func showBakingWithUIKit() {}
        func showBakingWithSwiftUI() {}
    }
    
    static var previews: some View {
        AppSelectionView(routing: Mock())
    }
}
