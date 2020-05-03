class Data {

  String dataKey;
  String userName;
  int userID;

  Data(this.userName, this.userID);

  toMap() {

    return {
      "userName" : userName,
      "userID" : userID,
    };
  }

  Data.fromMap(String key, Map<String, dynamic> map) {

    dataKey = key;
    userID = map["ID"];
    userName = map["Name"];
  }
}