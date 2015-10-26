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

- (void)registerStepWithDescription:(NSString *)description definition:(void (^)(void))definition {
  self.class.definitions[description] = [definition copy];
}

#pragma mark Global step definitions

+ (LookupFunc)lookup:(NSString *)description forStepInFile:(nonnull NSString *)filePath atLine:(NSUInteger)lineNumber {
  Step *step = [[Step alloc] initWithName:description inFile:filePath atLine:lineNumber];
  Class class = self.class;

  return ^StepDefinitionFunc _Nullable{
    NSDictionary *definitions = class.definitions;
    void (^definition)(void) = definitions[description];

    if (definition) {
      return ^{
        self.class.executingStep = step;
        @try {
          definition();
        }
        @finally {
          self.class.executingStep = nil;
        }
      };
    } else {
      return nil;
    }
  };
}

+ (NSMutableDictionary *)definitions {
  static NSMutableDictionary *definitions;
  static dispatch_once_t token;
  dispatch_once(&token, ^{ definitions = [NSMutableDictionary new]; });
  return definitions;
}

static Step *executingStep;

+ (Step *)executingStep {
  return executingStep;
}

+ (void)setExecutingStep:(nullable Step *)step {
  executingStep = step;
}

@end
