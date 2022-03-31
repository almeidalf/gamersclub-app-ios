//
//  WarmupViewController.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 26/03/22.
//

import IGListKit

final class WarmupViewController: UIViewController {
  // MARK: - Variables
  
  private var dataList: [ListDiffable] = []
  private var serversData: Server?
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.backgroundColor = .clear
    collectionView.refreshControl = refreshControl
    collectionView.keyboardDismissMode = .onDrag
    return collectionView
  }()
  
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = .black
//    refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    return refreshControl
  }()
  
  private lazy var adapter: ListAdapter = {
    let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    adapter.collectionView = collectionView
    adapter.dataSource = self
    return adapter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Warmup"
    view.backgroundColor = .white
    setupNavigationBar(withBackButton: true)
    getDataWarmup()
    setupViews()
  }
  
  private func setupViews() {
    view.addSubview(collectionView)
    
    collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  // MARK: - API
  
  private func getDataWarmup(completionHandler: ((_ success: Bool) -> Void)? = nil) {
    WarmupService().getWarmupData(page: 1, limit: 99) { response in
      
      switch response {
      case .success(let data):
        guard let servers = data.servers else { return }
        self.dataList.append(WarmupDiffable(sectionId: 1, servers: servers))
        self.adapter.performUpdates(animated: true)
        completionHandler?(true)
      case .failure(let error):
        print("ERRO", error.localizedDescription)
        completionHandler?(false)
      }
    }
  }
}

// MARK: - ListAdapterDataSource

extension WarmupViewController: ListAdapterDataSource {
  public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    return dataList
  }
  
  public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    return WarmupSectionController()
  }
  
  public func emptyView(for listAdapter: ListAdapter) -> UIView? {
    return nil
  }
}
