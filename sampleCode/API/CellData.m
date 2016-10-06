#import "CellData.h"

@implementation CellData
- (void)loadWithDictionary:(NSDictionary *)dict
{
    self.trackId = [[dict objectForKey:@"trackId"] intValue];
    self.artistName = [dict objectForKey:@"artistName"];
    self.artworkUrl30 = [dict objectForKey:@"artworkUrl30"];
    self.artworkUrl60 = [dict objectForKey:@"artworkUrl60"];
    self.artworkUrl100 = [dict objectForKey:@"artworkUrl100"];
    self.trackName = [dict objectForKey:@"trackName"];
}
@end
