//
//  HomeViewController.swift
//  XMMPAuth
// fetching city from api
// loading data using protocol
//  Created by Mahendra Vishwakarma on 24/10/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var cityListTableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    var viewModel:HomeViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    
    //MARK:configure tableview & viewModel
    fileprivate func configure() {
        viewModel = HomeViewModel()
        viewModel?.delegate = self
        activity.startAnimating()
        viewModel?.fetchCities()
        cityListTableView.register(UINib(nibName: CityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
        cityListTableView.dataSource = self
        cityListTableView.delegate = self
    }

}

extension HomeViewController:CityUpdateDelegate {
    func updateList(status: Int) {
        DispatchQueue.main.async{
            self.activity.stopAnimating()
            self.cityListTableView.reloadData()
        }
       
    }
    
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cityListObj?.list?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else{
            return UITableViewCell()
        }
        if let city = viewModel?.cityListObj?.list?[indexPath.row] {
            cell.textLabel?.text = city.name
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
