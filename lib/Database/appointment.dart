
class Point {

	int _id;
	String _title;
	String _description;
  String _days;
  String _times;
	String _date;
	int _priority;

	Point(this._title, this._date, this._days, this._times, this._priority, [this._description]);

	Point.withId(this._id, this._title, this._date, this._days, this._times, this._priority, [this._description]);

	int get id => _id;

	String get title => _title;

	String get description => _description;

	int get priority => _priority;

	String get date => _date;

  String get days => _days;

  String get times => _times;

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

		return map;
	}

	// Extract a Note object from a Map object
	Point.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._title = map['title'];
		this._description = map['description'];
		this._priority = map['priority'];
		this._date = map['date'];
    this._days = map['days'];
    this._times = map['times'];
	}
}
