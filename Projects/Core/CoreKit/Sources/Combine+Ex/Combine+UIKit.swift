//
//  Combine+UIKit.swift
//  CoreKit
//
//  Created by 정도현 on 9/10/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import Combine
import UIKit

// MARK: Protocol
public protocol CombineCompatible { }

// MARK: - UIControl
extension UIControl: CombineCompatible {}

public extension CombineCompatible where Self: UIControl {
  func publisher(for event: UIControl.Event) -> UIControl.Publisher<UIControl> {
    .init(output: self, event: event)
  }
}

public extension UIControl {
  final class Subscription<SubscriberType: Subscriber, Control: UIControl>: Combine.Subscription where SubscriberType.Input == Control {
    private var subscriber: SubscriberType?
    private let input: Control
    
    public init(subscriber: SubscriberType, input: Control, event: UIControl.Event) {
      self.subscriber = subscriber
      self.input = input
      input.addTarget(self, action: #selector(eventHandler), for: event)
    }
    
    public func request(_ demand: Subscribers.Demand) {}
    
    public func cancel() {
      subscriber = nil
    }
    
    @objc private func eventHandler() {
      _ = subscriber?.receive(input)
    }
  }
  
  struct Publisher<Output: UIControl>: Combine.Publisher {
    public typealias Output = Output
    public typealias Failure = Never
    
    let output: Output
    let event: UIControl.Event
    
    public init(output: Output, event: UIControl.Event) {
      self.output = output
      self.event = event
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
      let subscription = Subscription(subscriber: subscriber, input: output, event: event)
      subscriber.receive(subscription: subscription)
    }
  }
}

