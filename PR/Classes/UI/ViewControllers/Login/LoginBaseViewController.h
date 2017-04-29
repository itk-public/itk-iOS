//
//  LoginBaseViewController.h
//  PR
//
//  Created by 黄小雪 on 14/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^FinshBlcok)(BaseViewController *vc);

@interface LoginBaseViewController : BaseViewController

@property (copy,nonatomic) FinshBlcok finshBlock;

@end
