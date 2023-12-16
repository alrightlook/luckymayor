Lucky Mayor SandBox Player
------


- Features:
  1. Cross-Platform： 目前支持win64和mac-os,Android，ios，WebGL
  2. Lua脚本控制游戏逻辑。除了少量的Unity底层的表现实现，其他的全部采用Lua脚本控制 自由度非常高
  3. URP 2D rendering.
  4. 网络支持，无表现相关的lua脚本可以完全跑在一台Server上面。
  5. 资源热更新。
----

- 开发文档：
  1. 在将Lua文件夹放在**LuckyMayor.exe**(或者**mac-build**)的可执行文件旁边，游戏启动后会自动加载Lua中的脚本文件
  2. Lua文件夹下面分为三个主要模块：**core**, **logic**, **presentation** 分别表示 核心模块，游戏逻辑，表现层模块
  3. 编码采用UTF-8的编码格式，可以采用vscode 或者任何一个支持utf8编码的编辑器编码
    ```Lua
    --[[游戏默认的脚本根目录是Lua文件夹，
    如果你想要在A.lua 脚本中引用B文件夹下面的C.lua可以这样做：
    ]]
    local C = require('B.C') --目录的分割不再使用斜杠 而是点(.)
    
    ```
  4. `core` 这个模块主要维护了main的入口和Event消息管理模块，各个模块之间的通信通过Event脚本发送和监听消息完成的：其中大多数的脚本是自文档的。
   ``` Lua
   --Import 相关的模块
    local Event = require('core.Event')
    local MSG = Event.MSG

   --消息发送
   --通知表现层弹出一个选择市民的UI界面出来，参数可扩展，这里面的data就是透传的参数内容可以自定义
    function ChooseCityzen(data) 
        Event.Dispatch(MSG.ChooseCityzen, data)
    end

    --消息监听：
    Event.Listen(MSG.ChooseCityzen, function(data)
        ChooseCityzen.Create(data)
    end)
   ```
   5. `logic` 逻辑模块也有一个main的入口文件这里面注册各种事件的监听和响应函数
    ```Lua
    --在core.main中引用了logic.main
    local LogicMain = require('logic.main')
    ```

   6. `Presentation` 这个是游戏UI表现相关的模块，里面会有处理人物动画，资源加载的相关功能。

   Now you can play around with it!
