//
//  DebugEnvConfig.h
//  PR
//
//  Created by 黄小雪 on 16/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifndef DebugEnvConfig_h
#define DebugEnvConfig_h


/**
 *  为了对模块依赖进行解耦，这里的配置是依照AppStore的准则进行固化的。
 *  如果需要根据不同的环境调整不同的Debug选项，请在jenkins中根据
 *  编译环境动态修改此文件
 */
#if defined(DEBUG)
#define ISDebugOptionValid
#define kAutoToTestInEnvir

#else
#undef kAutoToTestInEnvir
#undef ISDebugOptionValid
#endif


#endif /* DebugEnvConfig_h */
