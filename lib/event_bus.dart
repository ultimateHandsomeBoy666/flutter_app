typedef void EventCallback(arg);

class EventBus {

  // 私有构造函数
  EventBus._internal();

  static EventBus _singleton = EventBus._internal();

  factory EventBus() => _singleton;

}