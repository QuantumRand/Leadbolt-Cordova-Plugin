//
//  AppTrackerPlugin.h
//  AppTrackerPlugin
//
//  Created by Jay on 26/09/13.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "AppTracker.h"

@interface AppTrackerPlugin : CDVPlugin<AppModuleDelegate>

-(void)startSession:(CDVInvokedUrlCommand *)command;
-(void)closeSession:(CDVInvokedUrlCommand *)command;
-(void)event:(CDVInvokedUrlCommand *)command;
-(void)transaction:(CDVInvokedUrlCommand *)command;
-(void)loadModule:(CDVInvokedUrlCommand *)command;
-(void)loadModuleToCache:(CDVInvokedUrlCommand *)command; 
-(void)destroyModule:(CDVInvokedUrlCommand *)command;
-(void)setAgeRange:(CDVInvokedUrlCommand *)command;
-(void)setGender:(CDVInvokedUrlCommand *)command;
@end
