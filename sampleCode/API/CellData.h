#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CellData : NSObject
@property (nonatomic, readwrite) int trackId;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) UIImage *appIcon;
@property (nonatomic, strong) NSString *artworkUrl30;
@property (nonatomic, strong) NSString *artworkUrl60;
@property (nonatomic, strong) NSString *artworkUrl100;
@property (nonatomic, strong) NSString *trackName;
- (void)loadWithDictionary:(NSDictionary *)dict;
@end
