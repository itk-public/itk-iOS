//
//  AppChannelConfig.h
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifndef AppChannelConfig_h
#define AppChannelConfig_h

#define FEATURE_APP_CHANNEL_APPSTORE    0
#define FEATURE_APP_CHANNEL_ENTERPRISE  1
#define FEATURE_APP_CHANNEL_ADHOC		2

#ifndef FEATURE_APP_CHANNEL
#ifdef DEBUG
#define FEATURE_APP_CHANNEL FEATURE_APP_CHANNEL_ADHOC
#else
#define FEATURE_APP_CHANNEL FEATURE_APP_CHANNEL_APPSTORE
#endif
#endif


#endif /* AppChannelConfig_h */
