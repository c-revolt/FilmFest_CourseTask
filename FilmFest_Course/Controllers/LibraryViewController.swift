//
//  ViewController.swift
//  FilmFest_Course
//
//  Created by Александр Прайд on 02.11.2022.
//

import UIKit

class LibraryViewController: UIViewController {

    @IBOutlet weak var libraryTableView: UITableView!
    @IBOutlet var dataService: MovieLibraryDataService!
    
    var movieManager = MovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.libraryTableView.dataSource = dataService
        self.libraryTableView.delegate = dataService
        self.libraryTableView.layer.cornerRadius = 10
        
        dataService.movieManager = movieManager
        
        dataService.movieManager?.addMovie(movie: Movie(title: "Action", releaseDate: "1999"))
        dataService.movieManager?.addMovie(movie: Movie(title: "Horror", releaseDate: "1989"))
        dataService.movieManager?.addMovie(movie: Movie(title: "Crime Thriller", releaseDate: "1979"))
        dataService.movieManager?.addMovie(movie: Movie(title: "Indie Comedy"))
        dataService.movieManager?.addMovie(movie: Movie(title: "Kung Fu Flic"))
        
        libraryTableView.reloadData()
    }

}

