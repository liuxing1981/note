# Harmony

访问网络权限

修改module.json5，在倒数第三行下面添加

```json5
  "requestPermissions": [{
      "name": "ohos.permission.INTERNET"
  }]
```



## Ability (demo project: Day3Test)

一个ability里，可以指定page文件，通过EntryAbility.ets的onWindowStageCreate方法指定，  
pages/Index来自于 entry\src\main\resources\base\profile\main_pages.json

```ts
 onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }
```

### 2个Ability切换

通过获取上下文context,调用context的startAbilityForResult方法，  
可以通过回调获取另一个页面回传过来的值，而startAbility方法，可以直接打开另一个ability  
Ability之间，主要依靠Want对象的parameters方法传值  
在另一个Ability的onCreate方法中，可以接收Want的值，并提取Want中parameters里传递过来的值  
把接收的值赋给AppStorage  
再在这个Ability中的页面中，用 @StorageProp("message") 接收值

1. 从UIAbility中获取上下文
   
   ```
   let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext
   ```

2. 封装Want对象
   
   ```
   let want: Want = {
            //指定对端Ability的名字，entry\src\main\resources\base\profile\main_pages.json
            abilityName: "SecondAbility",
            //从文件AppScope\app.json5获取 
            bundleName: "com.luis.myapplication",
            parameters: {
              "message": this.message
            }
          }
   ```

3. 调用context的startAbilityForResult方法，或startAbility方法
   
   ```
   // ForResult方法可以获取对端Ability的返回值
   context.startAbilityForResult(want).then((data)=>{
            this.backMessage = data.want?.parameters?.message as string
            this.allMessage.push(this.backMessage)
          })
   
   context.startAbility(want)
   ```

4. 对端Ability接收Want,在对端Ability的onCreate方法中接收
   将接收的Want对象提取，并set到全局对象AppStorage中
   
   ```
   onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    let message:string = want.parameters?.message as string
    AppStorage.setOrCreate("message", message) //key值为message
   }
   //从后台转到前台，需要构造onNewWant方法
   onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    let message:string = want.parameters?.message as string
    AppStorage.setOrCreate("message", message) //key值为message
   }
   
   ```

5. 对端Ability的页面从AppStorage中提取值,用@StorageProp/@StorageLink注解,这两个注解可以实时获取AppStorage里的值，注解的名字应跟AppStorage中key值一致
   
   ```
   @Entry
   @Component
   struct Second {
   @StorageProp("message") message: string = '';  //接收key为message的值
   ```

6. 如果调用的是startAbilityForResult方法，则需要在对端Ability页面把返回值传给主调页面  
   需要构造 common.AbilityResult 对象，并用context的terminateSelfWithResult方法
   
   ```
   let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext
   let result: common.AbilityResult = {
   resultCode: 0,
   want: {
    abilityName: "EntryAbility",
    bundleName: "com.luis.myapplication",
    parameters: {
    "message": this.backMessage
    }
   },
   }
   this.allMessage.push(this.backMessage)
   context.terminateSelfWithResult(result)
   ```

## Card(demo project: zfz02_7)

ets文件夹右键->New->Service Widget->Dynamic Widget  
文件名会自动加上单词Card  
建立完成以后系统自动建立以下文件：

* entry\src\main\resources\base\profile\form_config.json
* entry\src\main\ets\entryformability\EntryFormAbility.ets
* entry\src\main\ets\wallpaper\pages\WallpaperCard.ets

### 点击卡片，调起一个指定的Ability

1. 在card页面WallpaperCard.ets中调用 postCardAction方法，将值放入params的key为targetPage的json中
   
   ```
   postCardAction(this, {
        action: "router",
        abilityName: this.ABILITY_NAME,//调起Ability的名字 "EntryAbility"
        params: {
          "targetPage": "home"
        }
      })
   //action 可以选router或者message，router用于调起Ability，message用于卡片中变量值更新
   ```

2. 在EntryAbility的onCreate和onNewWant方法中的Want接收值,在onWindowStageCreate中指定调用的page
   
   ```
   export default class EntryAbility extends UIAbility {
   private selectPage: string = ""
   private currentWindowStage: window.WindowStage | null = null
   
      onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
      if(want.parameters?.params != null) {
        let params: Record<string,string> = JSON.parse(want.parameters?.params as string)
        this.selectPage = params?.targetPage
      }
      hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    }
   
    onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
      this.onCreate(want, launchParam)
      if (this.currentWindowStage != null) {
        this.onWindowStageCreate(this.currentWindowStage);
      }
    }
   
    onWindowStageCreate(windowStage: window.WindowStage): void {
      // Main window is created, set main page for this ability
      if(this.currentWindowStage === null) {
        this.currentWindowStage = windowStage
      }
      let entryPage = ''
      switch (this.selectPage) {
        case 'home': entryPage = 'pages/Index';break
        default: entryPage = 'pages/Index'
      }
      windowStage.loadContent(entryPage, (err) => {
        if (err.code) {
          hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
          return;
        }
        hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
      });
    }
   ```

3. 在页面获取值
   页面上需要用LocalStorage接收

```
  let storage = new LocalStorage() //模块级别
  @Entry(storage)
  @Component
  struct WallPaperCard {
    //演示message刷新的文本
    @LocalStorageProp('recommend') recommend: string = '浪漫田园风'
    //演示定时刷新的文本
    @LocalStorageProp('recommend2') recommend2: string = '现代简约风'
    //演示定点刷新的文本
    @LocalStorageProp('recommend3') recommend3: string = '动感朋克风'
```

### 手动点击卡片上按钮，刷新卡片的特定文字

1. 在页面的按钮上
   
   ```
   
   postCardAction(this, {
              action: "message"
            })
   
   ```

2. 在EntryFormAbility的onFormEvent方法中接收值
   
   ```
   
   onFormEvent(formId: string, message: string) {
      // Called when a specified message event defined by the form provider is triggered.
      let formData = new FormData()
      let formInfo: formBindingData.FormBindingData = formBindingData.createFormBindingData(formData)
      console.log("call onFormEvent")
      formProvider.updateForm(formId, formInfo).then(()=>{
      })
   
     }
     // 成员变量的名字要跟页面上@LocalStorageProp的变量名一致
     //定义要刷新的新值
     class FormData {
     private recommend: string = new Date().toLocaleTimeString('zh-CN')
   }  
   
   ```

3. 在页面获取值
   页面上需要用LocalStorage接收

```

let storage = new LocalStorage() //模块级别
@Entry(storage)
@Component
struct WallPaperCard {
  //演示message刷新的文本
  @LocalStorageProp('recommend') recommend: string = '浪漫田园风'
  //演示定时刷新的文本
  @LocalStorageProp('recommend2') recommend2: string = '现代简约风'
  //演示定点刷新的文本
  @LocalStorageProp('recommend3') recommend3: string = '动感朋克风'

```

### 定时刷新

1. 修改entry\src\main\resources\base\profile\form_config.json
   
   ```
   
    "updateEnabled": true,
    "scheduledUpdateTime": "16:05",
   
   ```

2. 修改EntryFormAbility.ets中的onUpdateForm方法
   
   ```
   
    onUpdateForm(formId: string) {
      console.log("call onUpdateForm")
      let formData = new FormData2()
      let formInfo = formBindingData.createFormBindingData(formData)
      console.log("call onFormEvent")
      formProvider.updateForm(formId, formInfo).then(()=>{
      })
      // Called to notify the form provider to update a specified form.
   
    }
    //定义要刷新的新值
    class FormData2 {
    private recommend2: string = new Date().toLocaleTimeString('zh-CN')
   
   }
   
   ```

3. 页面上需要用LocalStorage接收
   
   ```
   
   let storage = new LocalStorage() //模块级别
   @Entry(storage)
   @Component
   struct WallPaperCard {
    //演示message刷新的文本
    @LocalStorageProp('recommend') recommend: string = '浪漫田园风'
    //演示定时刷新的文本
    @LocalStorageProp('recommend2') recommend2: string = '现代简约风'
    //演示定点刷新的文本
    @LocalStorageProp('recommend3') recommend3: string = '动感朋克风'
   ```
