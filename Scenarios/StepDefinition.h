//  Copyright © 2015 Outware Mobile. All rights reserved.

@import XCTest;

typedef void (^StepDefinitionFunc)(void);
typedef StepDefinitionFunc _Nullable (^LookupFunc)(void);

@interface StepDefinition : XCTestCase

- (void)steps;

- (void)Given:(nonnull NSString *)description definition:(nonnull void (^)(void))definition;

- (void)Then:(nonnull NSString *)description definition:(nonnull void (^)(void))definition;

+ (nonnull LookupFunc)lookup:(nonnull NSString *)step;

@end
