今天遇到使用Spring Initializr快速创建springboot项目失败：Initialization failed for 'https://start.spring.io'
1、直接去浏览器中输入https://start.spring.io/，选择想要的配置，点击generate下载。
2、选择File>Settings>Http Proxy，修改过后，点击Check connection。输入https://start.spring.io/，如果提示Success则为成功。
3、打开setting，点击Appearance & Behavior，点击HTTP Proxy，选择Auto-detect proxy settings，勾选Automatic proxy configuration URL: 复选框，并在输入框中录入https://start.spring.io/
最后是把，https再换成http，重新试一下，我是到网页上下载才成功创建SpringBoot项目的。