import Foundation

public final class DetailDisplayLogicThreadWrapper: DetailDisplayLogic {
    public weak var displaying: DetailDisplayLogic?
    
    public init(displaying: DetailDisplayLogic? = nil) {
        self.displaying = displaying
    }
    
    public func displayUserInfo(viewModel: Detail.ViewModel) {
        displaying.executeInMainThread { displaying in
            displaying.displayUserInfo(viewModel: viewModel)
        }
    }
    
    public func displayDetail(_ detailList: [Detail.StatementViewModel]) {
        displaying.executeInMainThread { displaying in
            displaying.displayDetail(detailList)
        }
    }
    
    public func startLoading() {
        displaying.executeInMainThread { displaying in
            displaying.startLoading()
        }
    }
    
    public func stopLoading() {
        displaying.executeInMainThread { displaying in
            displaying.stopLoading()
        }
    }
}
