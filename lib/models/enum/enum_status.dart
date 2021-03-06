enum StatusType { All, Done, Pending, Cancel }

extension StatusTypeExtension on StatusType {
  int get value {
    final values = {
      StatusType.All: 0,
      StatusType.Done: 1,
      StatusType.Pending: 2,
      StatusType.Cancel: 3,
    };

    return values[this]!;
  }

  static StatusType fromInt(int value) {
    final values = {
      0: StatusType.All,
      1: StatusType.Done,
      2: StatusType.Pending,
      3: StatusType.Cancel,
    };

    return values[value]!;
  }
}
