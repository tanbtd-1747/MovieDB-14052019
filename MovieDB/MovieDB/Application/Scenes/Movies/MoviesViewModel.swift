//
//  MoviesViewModel.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

struct MoviesViewModel {
    let navigator: MoviesNavigatorType
    let useCase: MoviesUseCaseType
}

// MARK: - ViewModelType
extension MoviesViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<CategoryType>
        let reloadTrigger: Driver<CategoryType>
        let loadMoreTrigger: Driver<CategoryType>
        let selectMovieTrigger: Driver<IndexPath>
        let toSearchTrigger: Driver<Void>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let movieList: Driver<[Section<CellType>]>
        let selectedMovie: Driver<Void>
        let isEmptyData: Driver<Bool>
        let toSearch: Driver<Void>
    }
    
    enum CellType {
        case main(Movie)
        case alternate(Movie)
    }
    
    func transform(_ input: Input) -> Output {
        let loadMoreOutput = setupLoadMorePagingWithParam(
            loadTrigger: input.loadTrigger,
            getItems: useCase.getMoviesList,
            refreshTrigger: input.reloadTrigger,
            refreshItems: useCase.getMoviesList,
            loadMoreTrigger: input.loadMoreTrigger,
            loadMoreItems: useCase.loadMoreMoviesList)
        
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput
        
        let movieList = page
            .map { $0.items.map { $0 } }
            .asDriverOnErrorJustComplete()
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: fetchItems,
                                             loadTrigger: Driver.merge(loading, refreshing),
                                             items: movieList)
        let toSearch = input.toSearchTrigger
            .do(onNext: {
                self.navigator.toSearch()
            })
        
        let sections = movieList
            .map { (movies: [Movie]) -> [Section<CellType>] in
                self.configDataSource(from: movies)
            }
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(sections) { $1[$0.section].items[$0.row] }
            .map { cell in
                switch cell {
                case .main(let movie):
                    return movie
                case .alternate(let movie):
                    return movie
                }
            }
            .do(onNext: { movie in
                self.navigator.toMoviesDetail(movie: movie)
            })
            .mapToVoid()
        
        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItems,
            movieList: sections,
            selectedMovie: selectedMovie,
            isEmptyData: isEmptyData,
            toSearch: toSearch
        )
    }
    
    private func configDataSource(from movies: [Movie]) -> [Section<CellType>] {
        let mainCells = movies.map { CellType.main($0) }
        let alternateCells = movies.map { CellType.alternate($0) }
        
        let numMovies = movies.count
        let cells = mainCells[0..<numMovies / 2] + alternateCells[numMovies / 2..<numMovies]
        
        let sections = [Section<CellType>(items: cells.shuffled())]
        
        return sections
    }
}
