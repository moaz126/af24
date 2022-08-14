class chatNotificationList{
  final String msg;
  final bool left;
  chatNotificationList({
    required this.msg,
    required this.left
  });
}

List<chatNotificationList> msgsList = [
  chatNotificationList(msg: "hello", left:true),
  chatNotificationList(msg: "Hy", left:true),
  chatNotificationList(msg: "How are you", left:false),
  chatNotificationList(msg: "I am fine", left:true),
  chatNotificationList(msg: "Whats up", left:false),
  chatNotificationList(msg: "Nothing", left:true),
  chatNotificationList(msg: "What are you doing", left:false),
  chatNotificationList(msg: "Coding", left:true),
  chatNotificationList(msg: "Are you busy", left:true),
  chatNotificationList(msg: "Yes", left:false),
];