# LFMQTTService

基于阿里MQTT的二次开发

## 1. 整体技术方案 

### 1.1 场景说明


### 1.2 主题相关

### 1.3 前后台交互

* 后台只在用户是在线时发送消息。
* 前端进入前台发送登录消息。
* 前端进入后台发送断开消息。


### 1.4 消息格式

```
{
	"type":"xxxx",     //消息类型 
	"data":{}          //消息数据
}
```

ps:为方便后台存取,发送数据时，data的数据转化为jsonString。


## Installation

```ruby
pod 'LFMQTTService'
```

## Author

lf_sytc@hotmail.com

## License

LFMQTTService is available under the MIT license. See the LICENSE file for more info.
