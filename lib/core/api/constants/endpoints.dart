abstract class Endpoints {
  static String get login => "User/Login";
  static String get register => "User/Register";
  static String get lookup => "User/Dropdown";
  static String get createEvent => "Submission/Add";
  static String get getEventDropdowns => "Submission/Dropdown";
  static String get uploadEventPoster => "Submission/UploadPosterImage";
  static String get uploadProfilePic => "User/UploadUserImage";
  static String get getPagination => "Event/GetPagination";
  static String get getPaginationFilter => "Event/GetFilterPagination";
  static String get eventDetails => "Event/Details";
  static String get getComments => "Event/Comments";
  static String get addComment => "Event/Comment";
  static String get eventHome => "Event/Home";
  static String get favToggle => "Event/ToggleFavourite";
}
