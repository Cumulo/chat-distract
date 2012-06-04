
protocol

  browser-side:
    'add-topic':
      'string', (4 < .length < 30)
    'delete'
    'commit-post':
      'string': (4 < .length < 50)

  server-side:
    'topic-list':
      'topic-content': number
      'topic-content': number
    ''

规划
  消息从服务器中转, 到达所有客户端
  分开 topic 和 post, 同时接收所有准确提交的信息
  一个 log topic 记录成员的加入和退出
  只能在一个 topic, 可以接收当前 topic 的输入同步
  
