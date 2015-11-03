//
//  AppTrackerPlugin.m
//  AppTrackerPlugin
//
//  Created by Jay on 26/09/13.
//
//

#import "AppTrackerPlugin.h"
#import <Cordova/CDVPluginResult.h>
//#import "AppTracker.h"

@implementation AppTrackerPlugin

-(void) onModuleLoaded:(NSString *)placement {
    //To receive event, uncomment the line below and add your own onModuleLoaded() function to your js file
    NSString * javascript = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onModuleLoaded',{placement:'%@'});", placement];
    [self.commandDelegate evalJs:javascript];
}

-(void) onModuleClosed:(NSString *)placement {
    //To receive event, uncomment the line below and add your own onModuleClosed() function to your js file
    NSString * javascript = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onModuleClosed',{placement:'%@'});", placement];
    [self.commandDelegate evalJs:javascript];
}
-(void) onModuleClicked:(NSString *)placement {
    NSString * javascript = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onModuleClicked',{placement:'%@'});", placement];
    [self.commandDelegate evalJs:javascript];
}
-(void) onModuleCached:(NSString *)placement {
    //To receive event, uncomment the line below and add your own onModuleCached() function to your js file
    NSString * javascript = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onModuleCached',{placement:'%@'});", placement];
    [self.commandDelegate evalJs:javascript];
}
-(void) onModuleFailed:(NSString *)placement error:(NSString *)error cached:(BOOL)cached {
    //To receive event, uncomment the line below and add your own onModuleFailed() function to your js file
    NSString * javascript = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onModuleFailed',{placement:'%@', error:'%@', cached:%@});", placement,error,cached ? @"true":@"false"];
    [self.commandDelegate evalJs:javascript];
}
-(void) onMediaFinished:(BOOL)viewCompleted {
    //To receive event, uncomment the line below and add your own onMediaFinished() function to your js file
    NSString * javascript = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onMediaFinished',{viewCompleted:%@});", viewCompleted ? @"true":@"false"];
    [self.commandDelegate evalJs:javascript];
}

-(void)startSession:(CDVInvokedUrlCommand *)command
{
    NSString *apikey = [command.arguments objectAtIndex:0];
    NSLog(@"startSession key=%@", apikey);

    //[self initializeEventListeners];
    [AppTracker setFramework:@"phonegap"];
    [AppTracker setAppModuleDelete:self];
    [AppTracker startSession:apikey];

    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

-(void)closeSession:(CDVInvokedUrlCommand *)command
{
    [AppTracker closeSession];
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

-(void)event:(CDVInvokedUrlCommand *)command
{
    NSString *name = [command.arguments objectAtIndex:0];
    @try
    {
        float value = [[command.arguments objectAtIndex:1] floatValue];
        [AppTracker event:name value:value];
    }
    @catch (NSException *exception)
    {
        [AppTracker event:name];
    }
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

-(void)transaction:(CDVInvokedUrlCommand *)command
{
    NSString *name = [command.arguments objectAtIndex:0];
    float value = [[command.arguments objectAtIndex:1] floatValue];
    NSString *ccode = [command.arguments objectAtIndex:2];
    
    [AppTracker transaction:name value:value currencyCode:ccode];
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

-(void)loadModule:(CDVInvokedUrlCommand *)command
{
    NSString *location = [command.arguments objectAtIndex:0];
    NSString *userData = nil;
    if(command.arguments.count > 1)
    {
        userData = (NSString *)[command.arguments objectAtIndex:1];
    }
    if( userData == [NSNull null])
    {
        userData = nil;
    }
    NSLog(@"loadModule location=%@ userData=%@", location,userData);
    
    [AppTracker loadModule:location viewController:self.viewController withUserData:userData];
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

-(void)loadModuleToCache:(CDVInvokedUrlCommand *)command
{
    NSString *location = [command.arguments objectAtIndex:0];
    NSString *userData = nil;
    if(command.arguments.count > 1)
    {
        userData = (NSString *)[command.arguments objectAtIndex:1];
    }
    if( userData == [NSNull null])
    {
        userData = nil;
    } 
    
    [AppTracker loadModuleToCache:location withUserData:userData];
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

-(void)destroyModule:(CDVInvokedUrlCommand *)command
{
    [AppTracker destroyModule];
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

-(void)setCrashHandlerStatus:(CDVInvokedUrlCommand *)command
{
    
    NSString *mode = [command.arguments objectAtIndex:0];
    BOOL isOn = false;
    if (mode != nil && [mode isEqualToString:@"1"])
        isOn = true;
    
    NSLog(@"setCrashHandlerStatus mode=%@, isOn=%d", mode, isOn);
    
    [AppTracker setCrashHandlerStatus:isOn];
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    
}

-(void) fixAdOrientation:(CDVInvokedUrlCommand *)command
{
    int orientation = [[command.arguments objectAtIndex:0] intValue];
    [AppTracker fixAdOrientation:(AdOrientation)(orientation)];
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

-(void) setAgeRange:(CDVInvokedUrlCommand *)command
{
    NSString *arg = [command.arguments objectAtIndex:0];
    [AppTracker setAgeRange:arg];
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

-(void) setGender:(CDVInvokedUrlCommand *)command
{
    NSString *arg = [command.arguments objectAtIndex:0];
    [AppTracker setGender:arg];
    
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

-(void)initializeEventListeners
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSString *afw = @"AppFireworksNotification";
    [nc addObserverForName:@"onModuleLoaded" object:afw queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSString * placement = (NSString *)([note.userInfo objectForKey:@"placement"]);
        NSLog(@"from AppTracker.mm - onModuleLoaded:%@", placement);
        
        //To receive event, uncomment the line below and add your own onModuleLoaded() function to your js file
        NSString * javascript = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onModuleLoaded',{placement:'%@'});", placement];
        [self.commandDelegate evalJs:javascript];
    }];
    [nc addObserverForName:@"onModuleClosed" object:afw queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSString * placement = (NSString *)([note.userInfo objectForKey:@"placement"]);
        NSLog(@"from AppTracker.mm - onModuleClosed:%@", placement);
        
        //To receive event, uncomment the line below and add your own onModuleClosed() function to your js file
        NSString * javascript = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onModuleClosed',{placement:'%@'});", placement];
        [self.commandDelegate evalJs:javascript];
    }];
    [nc addObserverForName:@"onModuleFailed" object:afw queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSString * placement = (NSString *)([note.userInfo objectForKey:@"placement"]);
        NSString * error = (NSString *)[note.userInfo objectForKey:@"error"];
        NSString * cached = (NSString *)[note.userInfo objectForKey:@"cached"];
        
        NSString* msg = [NSString stringWithFormat:@"%@:%@:%@",placement,error,cached];
        NSLog(@"from AppTracker.mm - onModuleFailed:%@" , msg);
        
        //To receive event, uncomment the line below and add your own onModuleFailed() function to your js file
        NSString * javascript = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onModuleFailed',{placement:'%@', error:'%@', cached:%@});", placement,error,[cached isEqualToString:@"yes"] ? @"true":@"false"];
        [self.commandDelegate evalJs:javascript];
    }];
    [nc addObserverForName:@"onModuleCached" object:afw queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSString * placement = (NSString *)([note.userInfo objectForKey:@"placement"]);
        NSLog(@"from AppTracker.mm - onModuleCached:%@", placement);
        
        //To receive event, uncomment the line below and add your own onModuleCached() function to your js file
        NSString * javascript = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onModuleCached',{placement:'%@'});", placement];
        [self.commandDelegate evalJs:javascript];
    }];
    [nc addObserverForName:@"onMediaFinished" object:afw queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSString * viewCompleted = (NSString *)([note.userInfo objectForKey:@"viewCompleted"]);
        NSLog(@"from AppTracker.mm - onMediaFinished:%@", viewCompleted);
        
        //To receive event, uncomment the line below and add your own onMediaFinished() function to your js file
        NSString * javascript = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onMediaFinished',{viewCompleted:%@});", [viewCompleted isEqualToString:@"yes"] ? @"true":@"false"];
        [self.commandDelegate evalJs:javascript];
    }];
}
@end
