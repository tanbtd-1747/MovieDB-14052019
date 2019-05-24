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
            .do(onNext: { self.navigator.toSearch()
            })
        
        let cells = movieList
            .map { movies -> [CellType] in
                var cells = [CellType]()
                let mainCells = movies.map { CellType.main($0) }
                let alternateCells = movies.map { CellType.alternate($0) }
                for i in 0..<mainCells.count {
                    cells.append(alternateCells[i])
                    cells.append(mainCells[i])
                }
                return cells
            }
        
        let moviesListSection = cells
            .map {
                return [Section(items: $0)]
            }
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(cells) {
                return ($0, $1)
            }
            .map { indexPath, cells in
                let cell = cells[indexPath.row]
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
            movieList: moviesListSection,
            selectedMovie: selectedMovie,
            isEmptyData: isEmptyData,
            toSearch: toSearch
        )
    }
}
