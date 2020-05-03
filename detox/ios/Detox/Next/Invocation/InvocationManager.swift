//
//  InvocationManager.swift
//  DetoxTestRunner
//
//  Created by Leo Natan (Wix) on 2/20/20.
//

import UIKit

@objc(DTXInvocationManager) public class InvocationManager: NSObject {
	internal struct Keys {
		static let type = "type"
	}
	
	internal struct Types {
		static let action = "action"
		static let expectation = "expectation"
	}
	
	@objc(invokeWithDictionaryRepresentation:error:)
	public class func invoke(dictionaryRepresentation: [String: Any]) throws -> [String: Any] {
		let type = dictionaryRepresentation[Keys.type] as! String
		
		return try dtx_try { () -> [String: Any] in
			switch type {
			case Types.action:
				let action = Action.with(dictionaryRepresentation: dictionaryRepresentation)
				return action.perform() ?? [:]
			case Types.expectation:
				let expectation = Expectation.with(dictionaryRepresentation: dictionaryRepresentation)
				expectation.evaluate()
				return [:]
			default:
				fatalError("Unknown invocation type \(type)")
			}
		}
	}
}