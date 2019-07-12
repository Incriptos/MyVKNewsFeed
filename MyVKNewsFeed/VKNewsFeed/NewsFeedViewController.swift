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
    
    // cell create from Xib file
    tableView.register(UINib(nibName: "NewsFeedCell", bundle: nil),
                       forCellReuseIdentifier: NewsFeedCell.reuseId)
    
    // cell create from Code
    tableView.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
    
    
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
    view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
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
    
  }
  
}
