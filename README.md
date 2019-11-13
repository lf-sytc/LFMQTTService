# LFMQTTService

基于阿里MQTT的二次开发

## 1. 整体技术方案 

### 1.1 GroupID相关

背景：阿里云MQTT服务并没有区分环境，所以通过GroupID来区分。

* GID-Client-Develop
* GID-Client-Preview
* GID-Client-Release

### 1.2 主题相关

前台主题区分为两个   

负责发送消息 

* Topic_Uplink_Develop
* Topic_Uplink_Preview
* Topic_Uplink_Release

负责接收消息

* Topic_Instruct_Develop
* Topic_Instruct_Preview
* Topic_Instruct_Release

### 1.3 与后台交互消息格式

```
{
	"type":"xxxx",     //业务类型 
	"data":"",         //业务数据    
}
```

* 接收消息时业务数据（data）具体值由业务方处理

## Installation

```ruby
pod 'LFMQTTService'
```

## Author

lf_sytc@hotmail.com

## License

LFMQTTService is available under the MIT license. See the LICENSE file for more info.
