//
//  PortConfiguration.h
//  InKeLive
//
//  Created by 1 on 2017/1/5.
//  Copyright © 2017年 jh. All rights reserved.
//
//  感谢感谢 jh， 袁铮老师

#ifndef PortConfiguration_h
#define PortConfiguration_h

#pragma 映客接口

//映客所有接口？？？
#define AllUrl @"http://serviceinfo.inke.com/serviceinfo/info?uid=133825214"

//热门
#define INKeUrl @"http://service.inke.com/api/live/simpleall?uid=133825214"

//附近
#define NearByUrl @"http:/service.ingkee.com/api/live/near_recommend?uid=247164228&latitude=%f&longitude=%f"

#define NearFakeUrl @"http:/service.ingkee.com/api/live/near_recommend?uid=247164228&latitude=31.347102&longitude=121.5117"

//搜索页面
#define SEARCHURL @"http://service.inke.com/api/recommend/aggregate?&uid=133825214"

//搜索更多(小清新、好声音、搞笑达人)
#define SEARCHMOREURL @"http://service.inke.com/api/live/themesearch?uid=133825214&keyword=%@"

//搜索结果
#define SEARCHRESULTURL @"http://service.inke.com/api/user/search?uid=133825214&count=25&keyword=%@"



#endif /* PortConfiguration_h */
