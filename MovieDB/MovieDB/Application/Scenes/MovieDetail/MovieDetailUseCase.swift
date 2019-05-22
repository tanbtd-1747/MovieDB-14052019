//
//  MovieDetailUseCase.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol MovieDetailUseCaseType {
    func getMovieDetail(id: Int) -> Observable<MovieDetail>
}

struct MovieDetailUseCase: MovieDetailUseCaseType {
    let repository: MovieDetailRepositoryType
    
    func getMovieDetail(id: Int) -> Observable<MovieDetail> {
        return repository.getMovieDetail(id: id)
    }
}
