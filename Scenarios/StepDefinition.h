//  Copyright © 2015 Outware Mobile. All rights reserved.

@import XCTest;

typedef void (^StepDefinitionFunc)(void);
typedef StepDefinitionFunc _Nullable (^LookupFunc)(void);

@class Step;

@interface StepDefinition : XCTestCase

- (void)steps;

- (void)registerStepWithDescription:(nonnull NSString *)description definition:(nonnull void (^)(void))definition;

+ (nonnull LookupFunc)lookup:(nonnull NSString *)step forStepInFile:(nonnull NSString *)filePath atLine:(NSUInteger)lineNumber;

+ (nullable Step *)executingStep;

@end
