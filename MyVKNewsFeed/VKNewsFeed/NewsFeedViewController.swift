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
    
    tableView.register(UINib(nibName: "NewsFeedCell", bundle: nil),
                       forCellReuseIdentifier: NewsFeedCell.reuseId)
    
    interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
  }
  
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
    
    switch viewModel {
    case .displayNewsFeed(let feedViewModel):
      self.feedViewModel = feedViewModel
      tableView.reloadData()
    }
    
  }
  
}

// MARK: - Table View Delegate

extension NewsFeedViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 220
  }
  
}

// MARK: - Table View DataSource

extension NewsFeedViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return feedViewModel.cells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId, for: indexPath) as! NewsFeedCell
    
    let cellViewModel = feedViewModel.cells[indexPath.row]
    cell.set(viewModel: cellViewModel)
    
    return cell
  }
  
  
}
