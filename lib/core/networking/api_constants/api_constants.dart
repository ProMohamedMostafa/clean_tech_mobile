class ApiConstants {
  static const apiBaseUrl = "https://10.0.2.2:7111/api/v1/";
  static const loginUrl = "auth/login";
  static const changePasswordUrl = "auth/password/change";
  static const userCreateUrl = "users/create";
  static const userCreateProviderUrl = "providers/create";
  static const countriesUrl = "countries";
  static const rolesUrl = "authorization/roles";
  static const allUsersUrl = "users";
  static const allProvidersUrl = "providers/pagination";
  static const editUserUrl = "users/edit";
  static const areaEditUrl = "areas/edit";
  static const cityEditUrl = "cities/edit";
  static const organizationEditUrl = "organizations/edit";
  static const buildingEditUrl = "buildings/edit";
  static const floorEditUrl = "floors/edit";
  static const pointEditUrl = "points/edit";
  static const deleteUserListUrl = "users/deleted/index";
  static const deletedProvidersListUrl = "providers/deleted/index";

  static const createAreaUrl = "areas/create";
  static const createCityUrl = "cities/create";
  static const createOrganizationUrl = "organizations/create";
  static const createBuildingUrl = "buildings/create";
  static const createFloorUrl = "floors/create";
  static const createPointUrl = "points/create";

  static const areaUrl = "areas";
  static const cityUrl = "cities";
  static const organizationUrl = "organizations";
  static const buildingUrl = "buildings";
  static const floorUrl = "floors";
  static const pointUrl = "points";

  static const allDeletedAreaList = '/areas/deleted/index';
  static const allDeletedCityList = '/cities/deleted/index';
  static const allDeletedOrganizationList = '/organizations/deleted/index';
  static const allDeletedBuildingList = '/buildings/deleted/index';
  static const allDeletedFloorList = '/floors/deleted/index';
  static const allDeletedPointList = '/points/deleted/index';

  static const createShiftUrl = "shifts/create";
  static const allShiftsUrl = "shifts";
  static const editShiftsUrl = "shifts/edit";

  static const allShiftsDeletedUrl = "shifts/deleted/index";

  static const createTaskUrl = "tasks/create";
  static const allTasksUrl = "tasks";
  static const changeTaskStatusUrl = "update-status";
  static const editTaskUrl = "tasks/edit";
  static const getAllDeletedTasksUrl = "tasks/deleted/index";

  static const assignAreaUrl = "assign/area/manager";
  static const assignCityUrl = "assign/city/manager";
  static const assignOrganizationUrl = "assign/organization/manager";
  static const assignBuildingUrl = "assign/building/manager";
  static const assignFloorUrl = "assign/floor/manager";
  static const assignPointUrl = "assign/point/manager";
  static const assignShiftUrl = "assign/user/shift";
  static const assignOrganizationShiftUrl = "assign/organization/shift";
  static const assignBuildingShiftUrl = "assign/building/shift";
  static const assignFloorShiftUrl = "assign/floor/shift";
  static const assignPointShiftUrl = "assign/point/shift";
}
