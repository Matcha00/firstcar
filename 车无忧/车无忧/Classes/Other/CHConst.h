
#import <UIKit/UIKit.h>


typedef enum{
    CHTopicTypeAll = 1,
    CHTopicTypePicture = 10,
    CHTopicTypeWord = 29,
    CHTopicTypeVoice = 31,
    CHTopicTypeVideo = 41
}CHTopicType;


typedef NS_ENUM (NSInteger,CWYType) {
    CWYClearCar = 0,
    CWYHairdressing = 1,
    CWYMaintain = 2,
    CWYService = 3
};



UIKIT_EXTERN CGFloat const CHTitilesViewH;
UIKIT_EXTERN CGFloat const CHTitilesViewY;

UIKIT_EXTERN CGFloat const CHTopicCellMargin;

UIKIT_EXTERN CGFloat const CHTopicCellTextY;

UIKIT_EXTERN CGFloat const CHTopicCellBottomBarH;

UIKIT_EXTERN CGFloat const CHTopicCellPictureMaxH;

UIKIT_EXTERN CGFloat const CHTopicCellPictureBreakH;


UIKIT_EXTERN NSString * const CHUserSexMale;
UIKIT_EXTERN NSString * const CHUserSexFemale;
UIKIT_EXTERN NSString * const CHUrl;



UIKIT_EXTERN CGFloat const CHTopicCellTopCmtTitleH;


UIKIT_EXTERN NSString * const CHTabBarDidSelectNotification;



UIKIT_EXTERN CGFloat const CHTagMargin;

UIKIT_EXTERN CGFloat const CHTagH;
