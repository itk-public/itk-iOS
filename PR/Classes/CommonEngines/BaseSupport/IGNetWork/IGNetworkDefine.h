//
//  IGNetworkDefine.h
//  PR
//
//  Created by 黄小雪 on 10/01/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#ifndef IGNetworkDefine_h
#define IGNetworkDefine_h

//HRSC=Http Response Status Code
//先加了一点常用的
typedef NS_ENUM(NSInteger, HttpResponseStatusCode)
{
    //1xx
    HRSCContinue                     = 100,
    HRSCSwitchingProtocols           = 101,
    
    //2xx
    HRSCOK                           = 200,
    HRSCCreated                      = 201,
    HRSCAccepted                     = 202,
    HRSCNonauthoritativeInformation  = 203,
    HRSCNoContent                    = 204,
    HRSCResetContent                 = 205,
    HRSCPartialContent               = 206,
    
    //3xx
    HRSCMultipleChoices              = 300,
    HRSCMovedPermanently             = 301,
    HRSCFound                        = 302,
    HRSCSeeOther                     = 303,
    HRSCNotModified                  = 304,
    HRSCUseProxy                     = 305,
    HRSCUnused                       = 306,
    HRSCTemporaryRedirect            = 307,
    
    //4xx
    HRSCBadRequest                   = 400,
    HRSCUnauthorized                 = 401,
    HRSCForbidden                    = 403,
    HRSCNotFound                     = 404,
    HRSCMethodNotAllowed             = 405,
    HRSCNotAcceptable                = 406,
    HRSCProxyAuthenticationRequired  = 407,
    HRSCRequestTimeout               = 408,
    HRSCConflict                     = 409,
    HRSCGone                         = 410,
    HRSCLengthRequired               = 411,
    HRSCPreconditionFailed           = 412,
    HRSCRequestEntityTooLarge        = 413,
    HRSCRequestUrlTooLong            = 414,
    HRSCUnsupportedMediaType         = 415,
    HRSCRequestedRangeNotSatisfiable = 416,
    HRSCExpectationFailed            = 417,
    HRSCLocked                       = 423,
    
    //5xx
    HRSCInternalServerError          = 500,
    HRSCNotImplemented               = 501,
    HRSCBadGateway                   = 502,
    HRSCServiceUnavailable           = 503,
    HRSCGatewayTimeout               = 504,
    HRSCHTTPVersionNotSupported      = 505
};



typedef NS_ENUM(NSInteger, IGRespondStatus)
{
    IGOKRespondStatus = 0,
};



typedef NS_ENUM(NSInteger, IGInnerErrorCode)
{
    IGInnerErrorCodeBaseLine        =   -1,
    IGInnerErrorCodeNoNetwork       =   -90001,
    IGInnerErrorCodeNoValidRespond  =   -90002,
    IGInnerErrorCodeFileMD5Wrong    =   -100101,
    IGInnerErrorCodeWrongParam      =   -100201,
    IGInnerErrorCodeFileRSAWrong    = 45001,//RSA加密失败
    
    IGInnerErrorCodeLocation_Failed =   -10000001,
    IGInnerErrorCodeLocation_WrongData  = -10000002,
    IGInnerErrorCodeLocation_PremissionRestrict = -10000003,
};

#pragma todo: 这个key是否需要更高级别的保护
//#define    kIGSecurtKey     @"YONGHUI601933"


#endif /* IGNetworkDefine_h */
