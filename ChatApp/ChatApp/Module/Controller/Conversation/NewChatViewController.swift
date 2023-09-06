//
//  NewChatViewController.swift
//  ChatApp
//
//  Created by Elizeu RS on 29/07/23.
//

import UIKit
import Firebase

protocol NewChatViewControllerDelegate: AnyObject {
  func controller(_ vc: NewChatViewController, wantToChatWithUser otherUser: User)
}

class NewChatViewController: UIViewController {
  // MARK: - Properties
  
  weak var delegate:  NewChatViewControllerDelegate?
  private var filteredUsers: [User] = []
  private let searchController = UISearchController(searchResultsController: nil)
  
  private let tableView = UITableView()
  private let reuseIdentifier = "UserCell"
  private var users: [User] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }
  
  var inSearchMode: Bool {
    return searchController.isActive && !searchController.searchBar.text!.isEmpty
  }

//    init(users: [User]) {
//    self.users = users
//    super.init(nibName: nil, bundle: nil)
//  }
  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
  
  // MARK: - Lifescycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    configureUI()
    fetchUsers()
    configureSearchController()
  }
  
  // MARK: - Helpers
  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = 64
    tableView.backgroundColor = .systemBackground
    tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.tableFooterView = UIView() // Empty space add nothing.
    tableView.backgroundColor = .white
  }
  
  private func configureUI() {
    view.backgroundColor = .white
    title = "Search"
    
    view.addSubview(tableView)
    tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 15, paddingRight: 15)
  }
  
  private func fetchUsers() {
    showLoader(true)
    UserServices.fetchUsers { users in
      self.showLoader(false)
      self.users = users
      
      guard let uid = Auth.auth().currentUser?.uid else { return }
      guard let index = self.users.firstIndex(where: {$0.uid == uid}) else { return }
      self.users.remove(at: index)
//      print("\(users)")
    }
  }
  
  private func configureSearchController() {
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.obscuresBackgroundDuringPresentation = false
    definesPresentationContext = false
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Search"
    navigationItem.searchController = searchController
  }
}

// MARK: - TableView
extension NewChatViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return inSearchMode ? filteredUsers.count : users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
    let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
    cell.viewModel = UserViewModel(user: user)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
    delegate?.controller(self, wantToChatWithUser: user)
  }
}

// MARK: - UISearchResultsUpdating

extension NewChatViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
//    print(searchController.searchBar.text)
    guard let searchText = searchController.searchBar.text?.lowercased() else { return }
    filteredUsers = users.filter({$0.username.contains(searchText) || $0.fullname.lowercased().contains(searchText)})
    
    tableView.reloadData()
  }
}

// MARK: - UISearchBarDelegate

extension NewChatViewController: UISearchBarDelegate {
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
  }
  
  func NewChatViewController(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
    searchBar.text = nil
    searchBar.showsCancelButton = false
  }
}
