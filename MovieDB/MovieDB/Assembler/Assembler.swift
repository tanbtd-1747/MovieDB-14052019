//
//  AppAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

protocol Assembler: class,
    MainAssembler,
    MoviesAssembler,
    CategoriesAssembler,
    FavoritesAssembler,
    MovieDetailAssembler,
    MovieDetailReviewsAssembler,
    MovieDetailOverviewAssembler,
    VideoAssembler,
    CastCrewAssembler,
    RepositoriesAssembler,
    SearchAssembler,
    AppAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}
