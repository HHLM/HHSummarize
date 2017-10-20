//
//  HHCustomPickerView.m
//  HHCustomPickerView
//
//  Created by LXH on 2017/6/16.
//  Copyright © 2017年 HHLM. All rights reserved.
//

#import "HHCustomPickerView.h"
@class HHData;
@interface HHCustomPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString *_firstStr;
    
    NSString *_secondStr;
    
    NSString *_thirdStr;
    
    
    NSMutableArray *provinces;  //省
    
    NSMutableArray *citys;      //市
    
    NSMutableArray *districts;  //区
    
    HHAddressModel *provinceModel;
    
    HHAddressModel *cityModel;
    
    HHAddressModel *districtModel;
}

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UIToolbar  *toolBar;

@property (nonatomic, strong) UIButton   *rightBtn;

@property (nonatomic, strong) UIButton   *leftBtn;

@property (nonatomic, strong) UIView     *topView;

@property (nonatomic, strong) UIView     *showView;

@property (nonatomic, assign) HHPickerViewType pickerType;

@property (nonatomic, strong) NSArray *firstArray;

@property (nonatomic, strong) NSArray *secondArray;

@property (nonatomic, strong) NSArray *thirdArray;

@property (nonatomic, strong) HHData *cpdata;

@end

static const CGFloat kItemHeight    = 250.f;
static const CGFloat kRowHeight     = 30.f;
static const CGFloat kToolBarHeight = 40.f;

#define kPickerWidth    CGRectGetWidth(self.frame)
#define kPickerHeight   CGRectGetHeight(self.frame)

@implementation HHCustomPickerView

- (instancetype)initWithFrame:(CGRect)frame showView:(UIView *)showView  {
    self = [super initWithFrame:frame];
    if (self) {
        
        _showView = showView;
        
        provinces = [NSMutableArray array];
        
        citys     = [NSMutableArray array];
       
        districts = [NSMutableArray array];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
        
        [self.topView addSubview:self.toolBar];
        
        [self addSubview:self.topView];
        
        [self.toolBar addSubview:self.leftBtn];
        
        [self.toolBar addSubview:self.rightBtn];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenPicker:)];
        
        [self addGestureRecognizer:tap];
        
        [showView addSubview:self];

        
    }
    return self;
}
- (void)hiddenPicker:(UIGestureRecognizer*)tap {
    CGPoint point = [tap locationInView:self];
    if (point.y < kPickerHeight - kItemHeight) {
        [self hiddenPicker];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y < kPickerHeight - kItemHeight) {
        [self hiddenPicker];
    }
}
- (void)showPickerView:(HHPickerViewType)type {
    self.hidden = NO;
    _pickerType = type;
    if (_pickerType == HHPickerTimeType)
    {
        _firstArray = self.cpdata.timeArray;
        
        _secondArray = self.cpdata.timeArray;
        
        _firstStr = [_firstArray firstObject];
        
        _secondStr = [_secondArray firstObject];
    }
    else if (_pickerView == HHPickerAddrssType)
    {
        [provinces setArray: [HHData provices]];
        
        provinceModel = [provinces firstObject];
        
        [citys setArray:provinceModel.cityArray];
        
        cityModel = [citys firstObject];
        
        [districts setArray:cityModel.cityArray];
        
        districtModel = [districts firstObject];
        
        _firstStr = provinceModel.name;
        
        _secondStr = cityModel.name;

        _thirdStr = districtModel.name;
    }
    
    [self.topView addSubview:self.pickerView];
    
    [self showPickerView];
    
    [self.pickerView reloadAllComponents];
}
- (void)showPickerView {

    [UIView animateWithDuration:0.25 animations:^{
        [self.topView setFrame:CGRectMake(0, kPickerHeight - kItemHeight, kPickerWidth, kItemHeight)];
    }];
}
- (void)hiddenPicker {
    [UIView animateWithDuration:0.25 animations:^{
        [self.topView setFrame:CGRectMake(0, kPickerHeight, kPickerWidth, kItemHeight)];
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self.pickerView removeFromSuperview];
        self.pickerView = nil;
    }];
}
- (void)selectPicker {
    NSLog(@"%@", [NSString stringWithFormat:@"%@ - %@ - %@",_firstStr,_secondStr,_thirdStr?:@""]);
    if (_delegate && [_delegate respondsToSelector:@selector(pickerViewSelectString:)]) {
        [_delegate pickerViewSelectString:[NSString stringWithFormat:@"%@ - %@ - %@",_firstStr,_secondStr,_thirdStr?:@""]];
    }
    [self hiddenPicker];
}


#pragma mark -- delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    switch (_pickerType) {
        case HHPickerAddrssType:
            return 3;
            break;
        case HHPickerTimeType:
            return 2;
            break;
        default:
            break;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (_pickerType == HHPickerTimeType) {
        if (component == 0) {
            return _firstArray.count;
        }
        return _secondArray.count;
    }else {
        if (component == 0) {
            return provinces.count;
        }else if (component == 1){
            return citys.count;
        }
        return districts.count;
        
    }
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kRowHeight;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch (_pickerType) {
        case HHPickerAddrssType:
            return kPickerWidth/3;
            break;
        case HHPickerTimeType:
            return kPickerWidth/2;
            break;
        default:
            break;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    if (_pickerType == HHPickerAddrssType)
    {
        if (component == 0) {
            
            provinceModel = provinces[row];
            
            _firstStr = provinceModel.name;
            
            //得到城市数据
            [citys setArray:provinceModel.cityArray];
            
            cityModel = [citys firstObject];
            
            _secondStr = cityModel.name;
            
            [districts setArray:cityModel.cityArray];
            
            districtModel = [districts firstObject];
            
            _thirdStr = districtModel.name;
            
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
        else if (component == 1)
        {
            cityModel = citys[row];
            
            _secondStr = cityModel.name;
            
            [districts setArray:cityModel.cityArray];
            
            districtModel = [districts firstObject];
            
            _thirdStr = districtModel.name;
            
            [pickerView reloadComponent:2];
            
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
        else
        {
            //获取区域数据
            districtModel = districts[row];
            _thirdStr = districtModel.name;
        }
    }
    else
    {
        if (component == 0) {
            _firstStr = _firstArray[row];
            _secondStr = _secondStr?:[_secondArray firstObject];
        }else {
            _secondStr = _secondArray[row];
        }
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *myView = (UILabel *)view;
    if (!myView) {
        myView = [[UILabel alloc] init];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.font = [UIFont systemFontOfSize:16];
        myView.backgroundColor = [UIColor clearColor];
        myView.textColor = [UIColor redColor];
        [myView setFrame:CGRectMake(0, 0, kPickerWidth/2, kRowHeight)];
    }
    if (_pickerType == HHPickerAddrssType) {
        [myView setFrame:CGRectMake(0, 0, kPickerWidth/3, kRowHeight)];
        if (component == 0) {
            provinceModel = provinces[row];
            myView.text =  provinceModel.name;
        }else if (component == 1) {
            cityModel = citys[row];
            myView.text = cityModel.name;
        }else{
            districtModel = districts[row];
            myView.text = districtModel.name;
        }
        
    }else{
        if (component == 0) {
            myView.text = _firstArray[row];
        }else {
            myView.text = _secondArray[row];
        }
    }
    
    return myView;
}


#pragma mark -- UI Creat

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,kToolBarHeight, kPickerWidth, kItemHeight - kToolBarHeight)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
}
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, kPickerHeight, kPickerWidth, kItemHeight)];
        _topView.backgroundColor = [UIColor whiteColor];
    }
   return _topView;
}
- (UIToolbar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,  kPickerWidth, kToolBarHeight)];
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0f) {
            UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIButtonTypeCustom target:self action:@selector(hiddenPicker)];
            UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIButtonTypeCustom target:self action:@selector(selectPicker)];
            _toolBar.items = @[left,right];
        }
        
        
    }return _toolBar;
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kPickerWidth-50, 5, 40, 30)];
        [_rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(selectPicker) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }return _rightBtn;
}
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 40, 30)];
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(hiddenPicker) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }return _leftBtn;
}

- (HHData *)cpdata {
    if (!_cpdata) {
        _cpdata = [[HHData alloc] init];
    }return _cpdata;
}

@end

@class HHAddressModel;
@implementation HHData


- (NSArray *)timeArray {
    if (!_timeArray) {
        _timeArray = @[@"0:00",@"1:00",@"2:00",@"3:00",
                       @"4:00",@"5:00",@"6:00",@"7:00",
                       @"8:00",@"9:00",@"10:00",@"11:00",
                       @"12:00",@"13:00",@"14:00",@"15:00",
                       @"16:00",@"17:00",@"18:00",@"19:00",
                       @"20:00",@"21:00",@"22:00",@"23:00"];
    }return _timeArray;
}


+ (NSDictionary *)allAreas {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plist = [bundle pathForResource:@"area" ofType:@"plist"];
    return [[NSDictionary alloc] initWithContentsOfFile:plist];;
}

// 获取所有的省份名称
+ (NSArray *)provices{
    
    NSDictionary * areaDict = [HHData allAreas];
    
    NSArray *allKays = [HHData compareiosnSelectArray:[areaDict allKeys]];
    //  获取所有省份的key 通过key找到对应的 省份内容dict
    // dict的key 是省份的名称  value 是里面对应的城市
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (int i = 0; i < allKays.count; i ++) {
    
        // 循环便利所有省份的key 找对对应的省份
        NSString *key = allKays[i];
        
        //通过key 找到对应的省份内容
        NSDictionary *proviceDic = [areaDict objectForKey:key];
        
        // 省份对应的所有城市名称
        NSArray *citys = [HHData citysFromProvicesDict:proviceDic];
        
        // 省份名称
        NSString *provice = [[proviceDic allKeys] firstObject];
        
        NSLog(@"provice:%@--citys:%@",provice,citys);
        
        HHAddressModel *model = [[HHAddressModel alloc] init];
        
        model.name = provice;
        
        model.cityArray = citys;
        
        //把省份名称添加到省份数组中
        [dataArray addObject:model];
    }
    return dataArray;
}
//获取对应省份的所有城市名称
+ (NSArray *)citysFromProvicesDict:(NSDictionary *)proviceDict {
    
    NSMutableArray  *dataArray = [NSMutableArray array];
    
    // 获取省份的名字
    NSString *provices = [[proviceDict allKeys] firstObject];
    
    // 对应省份的信息
    NSDictionary * citysDict = [proviceDict objectForKey:provices];
    
    // 排序对应省份新的key 按照之前的顺序
    NSArray *cityKeys = [HHData compareiosnSelectArray:[citysDict allKeys]];
    
    for (int i = 0; i < cityKeys.count; i ++) {
        // key对应城市的信息
        NSDictionary *districtDict = [citysDict objectForKey:cityKeys[i]];
        
        // 获取城市中所有的区域
        NSArray  *districts = [HHData districtsFromCtiysDict:districtDict];
        
        // 城市的名称
        NSString *city = [[districtDict allKeys] firstObject];
        
        NSLog(@"city:%@--districts:%@",city,districts);
        
        HHAddressModel *model = [[HHAddressModel alloc] init];
        
        model.name = city;
        
        model.cityArray = districts;
        
        //城市名称添加到数据中
        [dataArray addObject:model];
    }
    return dataArray;
}
//获取对应城市的所有地区名称
+ (NSArray *)districtsFromCtiysDict:(NSDictionary *)citysDict {
    
    NSString *city = [[citysDict allKeys] firstObject];
    
    NSMutableArray  *dataArray = [NSMutableArray array];

    // 得到城市的所有的区域名称
    NSArray * districts = [citysDict objectForKey:city];
    
    for (int i = 0; i < districts.count; i ++) {
        
        HHAddressModel *model = [[HHAddressModel alloc] init];
        
        model.name = districts[i];
        
        [dataArray addObject:model];
    }
    
    return dataArray;
}


+ (NSArray *)compareiosnSelectArray:(NSArray *)array {
    return [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

@end
