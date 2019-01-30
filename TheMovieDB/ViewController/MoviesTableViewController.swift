//
//  MoviesTableViewController.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 26/01/19.
//  Copyright © 2019 SDvirtua Marketing Digital. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    var name: String?
    var movies: [Movies] = []
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var loadingMovies = false
    var currentPage: Int = 1
    var total = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        

        label.text = "Search Movies...loading..."
        loadMovies()
       
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MoviesViewController
        vc.movie = (sender as! Movies)
    }
    
    
    
    func loadMovies() {
        loadingMovies = true
        
        MovieDBAPI.loadMovies(title: name, page: currentPage) { (info) in
            if let info = info {
                
                self.movies.append(contentsOf: info.results)
                self.total = info.total_results
                
                print("Total:", self.total, "Inserted", self.movies.count)
                
                DispatchQueue.main.async {
                    self.loadingMovies = false
                    self.label.text = "Not found with nome \(self.name!)."
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    
//    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = movies.count == 0 ? label : nil
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell

        let movie = movies[indexPath.row]
        cell.prepareCell(with: movie)
        
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        self.performSegue(withIdentifier: "Details", sender: movie)
    }

    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 && !loadingMovies {
            currentPage += 1
            loadMovies()
            print("Loading more movies")
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


