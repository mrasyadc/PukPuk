//
//  DependencyInjection.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caearardhi on 13/08/24.
//

import Foundation
import SwiftData

// Grouping UseCase ke dalam satu fungsi
class DependencyInjection: ObservableObject {
    static let shared = DependencyInjection()

    private init() {}

    lazy var homeDataSource = HomeDataSource()

    lazy var homeDefaultRepository = HomeDefaultRepository(homeLocalDataSource: homeDataSource)

    lazy var homeUseCase = HomeUseCase(homeRepository: homeDefaultRepository)
    
    lazy var resultDataSource = ResultDataSource()
    
    lazy var resultDefaultRepository = ResultDefaultRepository(resultLocalDataSource: resultDataSource)
    
    lazy var resultUseCase = ResultUseCase(resultRepository: resultDefaultRepository)

    // MARK: FUNCTION

    func homeViewModel() -> HomeViewModel {
        HomeViewModel(homeUseCase: homeUseCase)
    }
    
    func resultViewModel() -> ResultViewModel {
        ResultViewModel(resultUseCase: resultUseCase)
    }
    
}

//// Singleton instance
// private var createPlanViewModelInstance: CreateEditPlanViewModel?
//
//// MARK: IMPLEMENTATION
//
// lazy var planLocalDataSource = PlanLocalDataSource(modelContext: modelContext!)
// lazy var aqiDataSource = AQIRemoteDataSource()
//
// lazy var planRepository = PlanRepository(planLocalDataSource: planLocalDataSource)
// lazy var aqiRepository = AQIRepository(AQIRemoteDataSource: aqiDataSource)
//
//// MARK: IMPLEMENTATION USE CASES
//
// lazy var getPlanPreviewUseCase = PlanUseCases(planRepository: planRepository, AQIRepository: aqiRepository)
// lazy var refreshPageViewUseCase = RefreshHomeViewUseCase(planRepository: planRepository)
//
//// MARK: TESTING
//
// lazy var dummyPlanRepository = DummyPlanRepository(dummyPlans: dummyPlans)
// lazy var dummyGetAllPlansPreviewUseCase = PlanUseCases(planRepository: dummyPlanRepository, AQIRepository: aqiRepository)
// lazy var dummyRefreshHomeViewUseCase = RefreshHomeViewUseCase(planRepository: DummyPlanRepository(dummyPlans: dummyPlans))
//
//// MARK: FUNCTION
//
// func homeViewModel() -> HomeViewModel {
//    HomeViewModel(
//        getAllPlansUseCase: getPlanPreviewUseCase
//    )
// }
