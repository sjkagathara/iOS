#import <UIKit/UIKit.h>
#import "CellData.h"
@interface CustomCell : UITableViewCell

- (void)loadWithData:(CellData *)chatData;
- (void)loadWithImage:(UIImage *)img;

@end
