# codingPractices -4
## GCD Group 與 GCD Semaphore 

在此專案中，串接了下列的 API：

臺北市 [Open API][id] 所提供之[臺北市固定測速照相地點表][id2] ，其所提供之 API 格式：

[id]:https://data.taipei/#/
[id2]: https://data.taipei/#/dataset/detail?id=745b8808-061f-4f5b-9a62-da1590c049a9

**URL:** https://data.taipei/opendata/datalist/apiAccess

**Method:** GET

**Header Params:** None

**Query String**

|Field|	Value
|-----|------------------------
scope|	resourceAquire
rid	|5012e8ba-5ace-4821-8482-ee07c147fd0a
limit|	Depends. 代表筆數上限(1000)
offset|	Depends. 代表位移筆數

**Request Example:**
```
https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=0
Success Response: 200
{
    "result": {
        "limit": 1,
        "offset": 0,
        "count": 143,
        "sort": "",
        "results": [
            {
                "functions": "測速",
                "area": "士林",
                "no": "1",
                "direction": "南向北",
                "speed_limit": "50",
                "location": "葫蘆街",
                "_id": 1,
                "road": "環河北路3段"
            }
        ]
    }
}
```

**畫面**
1. 總共有 6 個 UILabel，左右 2 個為一組
2. 每一組的資料分別各由一個 URLRequest 的 Response 的資料顯示（總共有三個 URLRequest）:

    * offset 為 0
    * offset 為 10
    * offset 為 20
    
3. 左側的 label 顯示路名（"road"），右側顯示速限（"speed_limit" ）
* 使用 GCD Group 處理資料顯示的情況：將三個 Response 的資料，```同時```顯示在畫面上 
* 使用 GCD Semaphore 處理資料顯示的情況：將三個 request 的 response 資料，```依序```(offset的順序) 顯示在畫面上

***畫面呈現***

![GITHUB](https://github.com/Sylviajiafen/codingPractices4/blob/master/print.png)

***GCD Group 情況下的 console***

![GITHUB](https://github.com/Sylviajiafen/codingPractices4/blob/master/withGroup.gif)

***GCD Semaphore 情況下的 console***

![GITHUB](https://github.com/Sylviajiafen/codingPractices4/blob/master/withSemaphore.gif)
