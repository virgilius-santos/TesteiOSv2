import Foundation

final class DetailDisplayLogicThreadWrapper: DetailDisplayLogic {
    weak var displaying: DetailDisplayLogic?
    
    init(displaying: DetailDisplayLogic? = nil) {
        self.displaying = displaying
    }
    
    func displayUserInfo(viewModel: Detail.ViewModel) {
        displaying.executeInMainThread { displaying in
            displaying.displayUserInfo(viewModel: viewModel)
        }
    }
    
    func displayDetail(_ detailList: [Detail.StatementViewModel]) {
        displaying.executeInMainThread { displaying in
            displaying.displayDetail(detailList)
        }
    }
    
    func startLoading() {
        displaying.executeInMainThread { displaying in
            displaying.startLoading()
        }
    }
    
    func stopLoading() {
        displaying.executeInMainThread { displaying in
            displaying.stopLoading()
        }
    }
}
