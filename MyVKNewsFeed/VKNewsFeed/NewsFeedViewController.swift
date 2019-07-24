//
//  NewsFeedViewController.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright (c) 2019 Andrew Vashulenko. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {

  @IBOutlet weak var tableView: UITableView!
  private var titleView = TitleView()
  private var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
    return refreshControl
  }()
  
  var interactor: NewsFeedBusinessLogic?
  var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
  
  private var feedViewModel = FeedViewModel.init(cells: [])
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsFeedInteractor()
    let presenter             = NewsFeedPresenter()
    let router                = NewsFeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    
    setupTableView()
    setupNavigationBar()
  
    view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    
    interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
    interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getUser)
  }
  
  private func setupTableView() {
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
    tableView.addSubview(refreshControl)
    // cell create from Xib file
    tableView.register(UINib(nibName: "NewsFeedCell", bundle: nil),
                       forCellReuseIdentifier: NewsFeedCell.reuseId)
    // cell create from Code
    tableView.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
  }
  
  private func setupNavigationBar() {
    self.navigationController?.hidesBarsOnSwipe = true
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationItem.titleView = titleView
  }
  
  @objc private func refreshFeed() {
    interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
  }
  
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
    
    switch viewModel {
    case .displayNewsFeed(let feedViewModel):
      self.feedViewModel = feedViewModel
      tableView.reloadData()
      refreshControl.endRefreshing()
    case .displayUser(let userViewModel):
      titleView.set(userViewModel: userViewModel)
    }
    
  }
  
}

// MARK: - Table View Delegate

extension NewsFeedViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let cellViewModel = feedViewModel.cells[indexPath.row]
    return cellViewModel.sizes.totalHeight
   
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    let cellViewModel = feedViewModel.cells[indexPath.row]
    return cellViewModel.sizes.totalHeight
  }
  
}

// MARK: - Table View DataSource

extension NewsFeedViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return feedViewModel.cells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // Celll from Xib
//   let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId, for: indexPath) as! NewsFeedCell
    
    // Cell from Code
    let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseId, for: indexPath) as! NewsFeedCodeCell
    cell.delegete = self
    let cellViewModel = feedViewModel.cells[indexPath.row]
    cell.set(viewModel: cellViewModel)
    
    return cell
  }
  
}

// MARK: - News Feed Code Cell Delegate

extension NewsFeedViewController: NewsFeedCodeCellDelegate {
  
  func fullSizePost(for cell: NewsFeedCodeCell) {
    guard let indePath = tableView.indexPath(for: cell) else { return }
    let cellViewModel = feedViewModel.cells[indePath.row]
    interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.openPostIds(postId: cellViewModel.postId))
  }
  
}
