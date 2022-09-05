const String domain = "http://localhost:3000";

const Map<String, String> jsonHeader = <String, String>{"Content-Type": "application/json; charset=UTF-8"};

Map<String, String> tokenHeader(String token) => <String, String>{"token": token, ...jsonHeader};
