class Note {
  int _id;
  String _title;
  String _description;
  String _days;
  String _times;
  String _date;
  String _pid;
  int _priority;

  Note(this._title, this._date, this._days, this._times,this._pid,this._priority,
      
      [this._description]);

  Note.withId(this._id, this._title, this._date, this._days, this._times, this._pid,
      this._priority,
      [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  int get priority => _priority;

  String get date => _date;

  String get days => _days;

  String get times => _times;

  String get pid => _pid;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 5) {
      this._priority = newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set days(String newDays) {
    this._days = newDays;
  }

  set times(String newTimes) {
    this._times = newTimes;
  }

  set pid(String newpid) {
    this._pid = newpid;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    map['days'] = _days;
    map['times'] = _times;
    map['pid'] = _pid;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
    this._days = map['days'];
    this._times = map['times'];
    this._pid = map['pid'];
  }
}
