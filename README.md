
Noisy Chat
------

This is a refactored project of [sync-chat][sync-chat]
with [`cumulo`][cumulo] and [`cumulo-client`][client].

[sync-chat]: https://github.com/Cumulo/sync-chat
[cumulo]: https://github.com/Cumulo/cumulo
[client]: https://github.com/Cumulo/cumulo-client

Here is how data flows in this app:

![](http://ww2.sinaimg.cn/bmiddle/62752320gw1en86390w6yj20ij0jewex.jpg)

### Develop this project

Install dependencies first:

```
npm i
```

Start server:

```
cd server
coffee app.coffee
```

Client JavaScript

```bash
gulp start
# visit generated index.html served with a web server
```

### License

MIT