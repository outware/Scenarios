//  Copyright © 2015 Outware Mobile. All rights reserved.

#import "StepDefinition.h"
#import "Features-Swift.h"

@implementation StepDefinition

+ (NSArray<NSInvocation *> *)testInvocations {
  [[self new] steps];
  return [NSArray new];
}

- (void)steps {}

#pragma mark Defining steps

- (void)Given:(NSString *)description definition:(void (^)(void))definition {
  self.class.definitions[description] = [definition copy];
}

- (void)Then:(NSString *)description definition:(void (^)(void))definition {
  self.class.definitions[description] = [definition copy];
}

+ (LookupFunc)lookup:(NSString *)step {
  Class class = self.class;
  return ^StepDefinitionFunc _Nullable{
    NSDictionary *definitions = class.definitions;
    return definitions[step];
  };
}

+ (NSMutableDictionary *)definitions {
  static NSMutableDictionary *definitions;
  static dispatch_once_t token;
  dispatch_once(&token, ^{ definitions = [NSMutableDictionary new]; });
  return definitions;
}

@end
