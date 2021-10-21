//
//  ViewController.swift
//  Movie Searcher
//
//  Created by 13polbr on 21.10.2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    @IBOutlet var field: UITextField!
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        field.delegate = self
    }

    
    //Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }
    
    func searchMovies(){
        field.resignFirstResponder()
        
        guard let text = field.text, !text.isEmpty else{
            return
        }
        
        movies.removeAll()
        
        URLSession.shared.dataTask(with: URL(string: "http://www.omdbapi.com/?i=tt3896198&apikey=e82e9215&s=fast%20&type=movie")!,
                                   completionHandler: {data, response, error in
                                    guard let data=data, error==nil else{
                                        return
                                    }
                                    //Convert data
                                    var result: MovieResult?
                                    do{
                                        result = try JSONDecoder().decode(MovieResult.self, from: data)
                                    }catch{
                                        print(error)
                                    }
                                    
                                    guard let finalResult = result else{
                                        return
                                    }
                                    
                                    print("\(finalResult.Search.first?.Title)")
                                    //Update movies array
                                    let newMoview = finalResult.Search
                                    self.movies.append(contentsOf: newMoview)
                                    
                                    //Refresh our table
                                    DispatchQueue.main.async {
                                        self.table.reloadData()
                                    }
                                    
        }).resume()
    }

    //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        //show movie details
    }
}

struct MovieResult: Codable{
    //Need to model the keys from the supposed got json response so swift will autoconvert
    //the data
    let Search: [Movie]
}

struct Movie: Codable{
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String
    
    private enum CodingKeys: String, CodingKey{
        case Title, Year, imdbID, _Type="Type", Poster
    }
    
}
