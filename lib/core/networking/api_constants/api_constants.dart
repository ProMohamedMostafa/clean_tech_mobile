class ApiConstants {
  // static const apiBaseUrl = "https://10.0.2.2:7111/api/v1/";
  static String apiBaseUrl = "http://192.168.1.27:8080/api/v1/";
  //static const apiBaseUrl = "http://192.168.23.100:8080/api/v1/";
  static const loginUrl = "auth/login";
  static const changePasswordUrl = "auth/password/change";
  static const userCreateUrl = "users/create";
  static const userCreateProviderUrl = "providers/create";
  static const nationalitiesUrl = "countries";
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
  static const sectionEditUrl = "sections/edit";
  static const pointEditUrl = "points/edit";
  static const deleteUserListUrl = "users/deleted/index";
  static const deletedProvidersListUrl = "providers/deleted/index";

  static const createAreaUrl = "areas/create";
  static const createCityUrl = "cities/create";
  static const createOrganizationUrl = "organizations/create";
  static const createBuildingUrl = "buildings/create";
  static const createFloorUrl = "floors/create";
  static const createSectionUrl = "sections/create";
  static const createPointUrl = "points/create";

  static const areaUrl = "areas/pagination";
  static const cityUrl = "cities/pagination";
  static const organizationUrl = "organizations/pagination";
  static const buildingUrl = "buildings/pagination";
  static const floorUrl = "floors/pagination";
  static const sectionUrl = "sections/pagination";
  static const pointUrl = "points/pagination";

  static const allDeletedAreaList = '/areas/deleted/index';
  static const allDeletedCityList = '/cities/deleted/index';
  static const allDeletedOrganizationList = '/organizations/deleted/index';
  static const allDeletedBuildingList = '/buildings/deleted/index';
  static const allDeletedFloorList = '/floors/deleted/index';
  static const allDeletedSectionList = '/sections/deleted/index';
  static const allDeletedPointList = '/points/deleted/index';

  static const createShiftUrl = "shifts/create";
  static const allShiftsUrl = "shifts/pagination";
  static const editShiftsUrl = "shifts/edit";

  static const allShiftsDeletedUrl = "shifts/deleted/index";

  static const createTaskUrl = "tasks/create";
  static const allTasksUrl = "tasks";
  static const changeTaskStatusUrl = "update-status";
  static const editTaskUrl = "tasks/edit";
  static const getAllDeletedTasksUrl = "tasks/deleted/index";

  static const assignAreaUrl = "assign/area/user";
  static const assignCityUrl = "assign/city/user";
  static const assignOrganizationUrl = "assign/organization/user";
  static const assignBuildingUrl = "assign/building/user";
  static const assignFloorUrl = "assign/floor/user";
  static const assignSectionUrl = "assign/section/user";
  static const assignPointUrl = "assign/point/user";
  static const assignShiftUrl = "assign/user/shift";
  static const assignOrganizationShiftUrl = "assign/organization/shift";
  static const assignBuildingShiftUrl = "assign/building/shift";
  static const assignFloorShiftUrl = "assign/floor/shift";
  static const assignSectionShiftUrl = "assign/section/shift";

  static const hisotryUrl = "attendance/history";
  static const leavesUrl = "leaves/pagination";
  static const leavesCreateUrl = "leaves/create";
  static const leavesEditUrl = "leaves/edit";

  static const createCategoryUrl = "categories/create";
  static const categoryUrl = "categories/pagination";
  static const deleteCategoryListUrl = "categories/deleted/index";
  static const editCategoryUrl = "categories/edit";

  static const createMaterialUrl = "materials/create";
  static const materialUrl = "materials/pagination";
  static const deleteMaterialListUrl = "materials/deleted/index";
  static const editMaterialUrl = "materials/edit";

  static const transactionUrl = "stock/transactions";
}
