class Joke {

  String? iconUrl;
  String? id;
  String? value;

  Joke(this.iconUrl, this.id, this.value);

  Joke.fromJson(Map<String, dynamic> json) {
    iconUrl = json['icon_url'];
    id = json['id'];
    value = json['value'];
  }

}