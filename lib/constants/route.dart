const homePageRoute = '/';
const addNewUserRoute = '/addNewUser';
const userRoute = '/user/';
const userDetailRoute = '/user/:userId';
String getUserDetailRoute({required int userId}) {
  return userDetailRoute + userId.toString();
}
