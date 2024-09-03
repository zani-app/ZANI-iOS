//
//  BaseService.swift
//  Networks
//
//  Created by 정도현 on 9/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import CoreKit

import Alamofire
import Combine
import Foundation
import Moya

open class BaseService<Target: TargetType> {
  
  typealias API = Target
  
  private(set) var cancelBag = CancelBag()
  
  lazy var provider = self.moyaProvider
  
  private lazy var moyaProvider: MoyaProvider<API> = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 10
    configuration.timeoutIntervalForResource = 10
    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData  // Local Cache 접근 무시
    
    // let interceptor = AuthInterceptor()
    
    let session = Session(
      configuration: configuration
    )
    
    let provider = MoyaProvider<API>(
      endpointClosure: endpointClosure,
      session: session,
      plugins: [MoyaLoggingPlugin()]
    )
    
    return provider
  }()
  
  private lazy var testingProvider: MoyaProvider<API> = {
    let testingProvider = MoyaProvider<API>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
    return testingProvider
  }()
  
  private lazy var testingProviderWithError: MoyaProvider<API> = {
    let testingProvider = MoyaProvider<API>(endpointClosure: endpointClosureWithError, stubClosure: MoyaProvider.immediatelyStub)
    return testingProvider
  }()
  
  private let endpointClosure = { (target: API) -> Endpoint in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    var endpoint: Endpoint = Endpoint(
      url: url,
      sampleResponseClosure: {.networkResponse(200, target.sampleData)},
      method: target.method,
      task: target.task,
      httpHeaderFields: target.headers
    )
    return endpoint
  }
  
  private let endpointClosureWithError = { (target: API) -> Endpoint in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    var endpoint: Endpoint = Endpoint(
      url: url,
      sampleResponseClosure: {.networkResponse(400, target.sampleData)},
      method: target.method,
      task: target.task,
      httpHeaderFields: target.headers
    )
    return endpoint
  }
  
  // Judge Network Status
  private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, type: T.Type) throws -> T {
    let decoder = JSONDecoder()
    
    guard let decodedData = try? decoder.decode(BaseEntity<T>.self, from: data) else {
      throw NetworkError.decodingFailed
    }
    
    switch statusCode {
    case 200..<300:
      return decodedData.data
      
    case 400..<500:
      throw NetworkError.requestErr
      
    case 500:
      throw NetworkError.serverError
      
    default:
      throw NetworkError.unknown
    }
  }
  
  public init() { }
}

// MARK: Provider
public extension BaseService {
  var `default`: BaseService {
    self.provider = self.moyaProvider
    return self
  }
  
  var test: BaseService {
    self.provider = self.testingProvider
    return self
  }
  
  var testWithError: BaseService {
    self.provider = self.testingProviderWithError
    return self
  }
}

// MARK: - MakeRequests

extension BaseService {
  
  func requestObjectWithNetworkError<T: Codable>(_ target: API) -> AnyPublisher<T, Error> {
    return Future { [weak self] promise in
      
      guard let self = self else { return }
      
      self.provider.request(target) { response in
        switch response {
        case let .success(value):
          do {
            guard let response = value.response else {
              throw NSError(domain: "Network - Invalid Response", code: -1000)
            }
            
            let result = try self.judgeStatus(by: response.statusCode, value.data, type: T.self)
            promise(.success(result))
            
          } catch {
            promise(.failure(error))
          }
          
        case let .failure(error):
          promise(.failure(error))
        }
      }
    }
    .eraseToAnyPublisher()
  }
  
  func requestObjectWithNoResult(_ target: API) -> AnyPublisher<Int, Error> {
    return Future { promise in
      self.provider.request(target) { response in
        switch response {
        case .success(let value):
          promise(.success(value.statusCode))
        case .failure(let error):
          promise(.failure(error))
        }
      }
    }.eraseToAnyPublisher()
  }
}
