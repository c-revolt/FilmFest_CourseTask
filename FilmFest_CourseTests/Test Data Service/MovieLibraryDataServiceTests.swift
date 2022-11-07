//
//  MovieLibraryDataServiceTests.swift
//  FilmFest_CourseTests
//
//  Created by Александр Прайд on 04.11.2022.
//

import XCTest
@testable import FilmFest_Course

final class MovieLibraryDataServiceTests: XCTestCase {

    var sut: MovieLibraryDataService!
    var libraryTableView: UITableView!
    var libraryVC: LibraryViewController!
    var tableViewMock: TableViewMock!
    
    let fairyTale = Movie(title: "Fairy Tale")
    let triller = Movie(title: "Triller")
    let darkComedy = Movie(title: "Dark Comedy")
    
    override func setUpWithError() throws {
        sut = MovieLibraryDataService()
        sut.movieManager = MovieManager()
        
        tableViewMock = TableViewMock.initMock(dataSource: sut)
        
        libraryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LibraryViewControllerID") as? LibraryViewController
        _ = libraryVC.view
        
        libraryTableView = libraryVC.libraryTableView
        libraryTableView.dataSource = sut
        libraryTableView.delegate = sut
    }

    override func tearDownWithError() throws {
        
    }

    // MARK: Sections
    func testTableViewSections_Count_ReturnsTwo() {
        
        let sections = libraryTableView.numberOfSections
        XCTAssertEqual(sections, 2)
    }
    
    func testTableViewSections_SectionOne_ReturnsMoviesToSeeCount() {
//        sut.movieManager?.addMovie(movie: fairyTale)
//        sut.movieManager?.addMovie(movie: darkComedy)
//
//        XCTAssertEqual(libraryTableView.numberOfRows(inSection: 0), 2)
//
//        sut.movieManager?.addMovie(movie: triller)
//        libraryTableView.reloadData()
        
        XCTAssertEqual(libraryTableView.numberOfRows(inSection: 0), 5)
    }
    
    func testTableViewSections_SectionTwo_ReturnsMoviesToSeenCount() {
//        sut.movieManager?.addMovie(movie: fairyTale)
//        sut.movieManager?.addMovie(movie: darkComedy)
//        sut.movieManager?.checkOffMovieAtIndex(index: 0)
//        XCTAssertEqual(libraryTableView.numberOfRows(inSection: 1), 1)
//
//        sut.movieManager?.checkOffMovieAtIndex(index: 0)
//        libraryTableView.reloadData()
        XCTAssertEqual(libraryTableView.numberOfRows(inSection: 1), 0)
    }
    
    // MARK: Cells
    func testCell_RowAtIndex_ReturnsMoviesMovieCell() {
        sut.movieManager?.addMovie(movie: darkComedy)
        libraryTableView.reloadData()
        
        let cellQueried = libraryTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cellQueried is MovieCell)
    }
    
    func testCell_ShouldDequeueCell() {
        
        sut.movieManager?.addMovie(movie: triller)
        tableViewMock.reloadData()
        _ = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(tableViewMock.cellDequeuedProperly)
        
    }
    
    func testCell_SectionOneConfig_ShouldSetCellData() {
        
        sut.movieManager?.addMovie(movie: fairyTale)
        tableViewMock.reloadData()
        
        let cell = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 0)) as! MovieCellMock
        XCTAssertEqual(cell.movieData, fairyTale)
    }
    
    func testCell_SectionTwoConfig_ShouldSetCellData() {
        sut.movieManager?.addMovie(movie: darkComedy)
        sut.movieManager?.addMovie(movie: fairyTale)
        sut.movieManager?.checkOffMovieAtIndex(index: 0)
        
        tableViewMock.reloadData()
        
        let cell = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 1)) as! MovieCellMock
        
        XCTAssertEqual(cell.movieData, darkComedy)
    }
    
    func testCell_Section_ShouldCheckOffSelectedMovie() {
        sut.movieManager?.addMovie(movie: fairyTale)
        sut.movieManager?.addMovie(movie: darkComedy)
        libraryTableView.delegate?.tableView?(libraryTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(sut.movieManager?.moviesToSeeConut, 1)
        XCTAssertEqual(sut.movieManager?.moviesSeenCount, 1)
        XCTAssertEqual(libraryTableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(libraryTableView.numberOfRows(inSection: 1), 1)
    }
    
    func testTableViewDataSectionTitles_ShouldHaveCorrectStringValues() {
        
        let section1Title = libraryTableView.dataSource?.tableView!(libraryTableView, titleForHeaderInSection: 0)
        let section2Title = libraryTableView.dataSource?.tableView!(libraryTableView, titleForHeaderInSection: 1)
        
        XCTAssertEqual(section1Title, "Movies To See")
        XCTAssertEqual(section2Title, "Movies Seen")
    }
}
