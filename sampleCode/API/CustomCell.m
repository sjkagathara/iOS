#import "CustomCell.h"


@interface CustomCell ()
@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;
@property (nonatomic, weak) IBOutlet UITextView *messageTextView;
@property (nonatomic, weak) IBOutlet UIImageView *picImageView;
@end

@implementation CustomCell

- (void)awakeFromNib
{
    // Initialization code
    self.picImageView.layer.cornerRadius = self.picImageView.frame.size.width / 2;
    self.picImageView.clipsToBounds = YES;
}

- (void)loadWithData:(CellData *)cellData
{
    self.usernameLabel.text = cellData.artistName;
    self.messageTextView.text = cellData.trackName;
    
}

- (void)loadWithImage:(UIImage *)img
{
     self.picImageView.image = img;
}



@end
