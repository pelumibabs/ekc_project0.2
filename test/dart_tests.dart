void main(){
  // Dict Sample
  // Map 1 = Chats as key
  // Map 2 = meUser / guestUser as key
  // Map 3 = msgs as key (Not available cuz emailUser Key)
  // Map<String, Map<String, Map<String, Map>>> chatsDict = {
  Map chatsDict = {
  // Map<String, Map<String, Map>> chatsDict = {
    'chats': {
      'meUser': {
        'emailUser': 'idanbit80@gmail.com',
        'msgs' : {
          '1' : {
            'msgChatIndex': 1,
            'msgText': 'I have news',
            'timeStamp': 12.00,
            'uniqueKey': 'XXX'
          },
          '3' : {
            'msgChatIndex': 3,
            'msgText': 'Chat mock works.',
            'timeStamp': 12.50,
            'uniqueKey': 'ZZZ'
          }
        }
      },
      'guestUser': {
        'emailUser': 'oleg@gmail.com',
        'msgs' : {
          '2' : {
            'msgChatIndex': 2,
            'msgText': 'What is it?',
            'timeStamp': 12.10,
            'uniqueKey': 'YYY'
          },
        }
      }
    }
  };

  List a = ['a', 'b', 'c'];
  List b = ['a', 'b', 'c'];

  List<List> c = [a, b];

  var newUserId;

  c.forEach((element) {
    element.forEach((element) {
      newUserId = element;
    });
  });

  a.add(newUserId);
  print(a);
}