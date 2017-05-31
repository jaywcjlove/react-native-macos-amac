#import "AppDelegate.h"

#import "RCTBridge.h"
#import "RCTJavaScriptLoader.h"
#import "RCTRootView.h"
#import <Cocoa/Cocoa.h>

@interface AppDelegate() <RCTBridgeDelegate>

@end

@implementation AppDelegate

-(id)init
{
    if(self = [super init]) {
        NSRect contentSize = NSMakeRect(200, 500, 1000, 500); // initial size of main NSWindow

        self.window = [[NSWindow alloc] initWithContentRect:contentSize
                                                  styleMask:NSTitledWindowMask | NSResizableWindowMask | NSFullSizeContentViewWindowMask | NSMiniaturizableWindowMask | NSClosableWindowMask
                                                    backing:NSBackingStoreBuffered
                                                      defer:NO];
        NSWindowController *windowController = [[NSWindowController alloc] initWithWindow:self.window];
        [[self window] setTitle:@"UIExplorerApp"];
        [[self window] setTitleVisibility:NSWindowTitleHidden];
        [[self window] setTitlebarAppearsTransparent:YES];
//        [[self window] setAppearance:[NSAppearance appearanceNamed:NSAppearanceNameAqua]];
        [[self window] setAppearance:[NSAppearance appearanceNamed:NSAppearanceNameVibrantLight]];

        [windowController setShouldCascadeWindows:NO];
        [windowController setWindowFrameAutosaveName:@"app"];
        //  if( (newOrigin.y+windowFrame.size.height) > (screenFrame.origin.y+screenFrame.size.height) ){
        //    newOrigin.y=screenFrame.origin.y + (screenFrame.size.height-windowFrame.size.height);
        //  }
        //  [self setFrameOrigin:newOrigin];

        [windowController showWindow:self.window];
      
      
      
      
        // -- Init Toolbar
        NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:@"mainToolbar"];
        [toolbar setSizeMode:NSToolbarSizeModeRegular];
//      [toolbar setSizeMode:NSToolbarSizeModeSmall];
        [self.window setToolbar:toolbar];
      

        [self setUpApplicationMenu];
    }
    return self;
}




- (void)applicationDidFinishLaunching:(__unused NSNotification *)aNotification
{

    _bridge = [[RCTBridge alloc] initWithDelegate:self
                                              launchOptions:nil];

    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:_bridge
                                                     moduleName:@"app"
                                              initialProperties:nil];



    [self.window setContentView:rootView];
}


- (NSURL *)sourceURLForBridge:(__unused RCTBridge *)bridge
{
    NSURL *sourceURL;

#if DEBUG
    sourceURL = [NSURL URLWithString:@"http://localhost:8081/index.macos.bundle?platform=macos&dev=true"];
#else
    sourceURL = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif

    return sourceURL;
}

- (void)loadSourceForBridge:(RCTBridge *)bridge
                  withBlock:(RCTSourceLoadBlock)loadCallback
{
    [RCTJavaScriptLoader loadBundleAtURL:[self sourceURLForBridge:bridge]
                              onComplete:loadCallback];
}


- (void)setUpApplicationMenu
{
    NSMenuItem *containerItem = [[NSMenuItem alloc] init];
    NSMenu *rootMenu = [[NSMenu alloc] initWithTitle:@"" ];
    [containerItem setSubmenu:rootMenu];
    [rootMenu addItemWithTitle:@"Quit app" action:@selector(terminate:) keyEquivalent:@"q"];
    [[NSApp mainMenu] addItem:containerItem];
}


//---鼠标拖拽----------------------------------------------------------------
//- (void)mouseDown:(NSEvent *)theEvent
//{
//  
//  
//  NSRect  windowFrame = [self frame];
//  initialLocation = [NSEvent mouseLocation];
//  
//  initialLocation.x -= windowFrame.origin.x;
//  initialLocation.y -= windowFrame.origin.y;
//}
////-------------------------------------------------------------------------
//- (void)mouseDragged:(NSEvent *)theEvent
//{
//  NSPoint currentLocation;
//  NSPoint newOrigin;
//  
//  NSRect  screenFrame = [[NSScreen mainScreen] frame];
//  NSRect  windowFrame = [self frame];
//  
//  currentLocation = [NSEvent mouseLocation];
//  newOrigin.x = currentLocation.x - initialLocation.x;
//  newOrigin.y = currentLocation.y - initialLocation.y;
//  
//  // Don't let window get dragged up under the menu bar
//  if( (newOrigin.y+windowFrame.size.height) > (screenFrame.origin.y+screenFrame.size.height) ){
//    newOrigin.y=screenFrame.origin.y + (screenFrame.size.height-windowFrame.size.height);
//  }
//  [self setFrameOrigin:newOrigin];
//}
//---鼠标拖拽----------------------------------------------------------------

- (id)firstResponder
{
    return [self.window firstResponder];
}

@end
