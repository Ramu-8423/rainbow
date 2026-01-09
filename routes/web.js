import express from "express";
import { loginPage, loginSubmit, dashboard ,logout, editProfile, updateProfile} from "../controllers/AuthController.js";

import { 
    jobApplication,
    allUsers,
    updateUserStatus,
    allCategories,
    updateCategoryStatus,
    subcategoriesPage,
    subcategoriesListAjax,
    subcategoryStatusUpdate,
    addCategory,
    addSubcategory,
    allSettings,
    updateSetting
} from "../controllers/PublicController.js";

import { 
driver_controller,
driverView,
updateDriverStatus,
approveAllDocuments,
driverLoginStatus
} from "../controllers/driverController.js";


import { 
allServiceman,
updateServicemanStatus
} from "../controllers/serviceManController.js";


import { 
getBankDetails,
getBankUpdateRequests,
updateRequestStatus
} from "../controllers/BankController.js";

import { 
DriverWithdrawRequest,
updateWithdrawRequest,
ServicemanWithdrawRequest,
updateServicemanWithdrawRequest
} from "../controllers/withdrawController.js";



import { 
vehicleList,
addVehicle,
updateVehicleStatus,
brandList,
updateBrandStatus,
addBrand,
updateBrand,
updateVehicle,
modelList,
getBrandsByVehicle,
getModelsByFilter,
addModel,
updateModel,
updateModelStatus,
vehicleAmountList,
vehicleAmountAdd,
vehicleAmountUpdate,
vehicleAmountDelete
} from "../controllers/vehicleController.js";


import { 
allServisesa,
getSubcategoriesByCategory,
storeService,
updateServiceStatus,
deleteService
} from "../controllers/serviceController.js";

import { uploadImageDynamic } from "../middleware/upload.js";

const router = express.Router();

router.get("/login", loginPage);
router.post("/login", loginSubmit);
router.get("/logout", logout);
router.get("/dashboard", dashboard);
router.get("/editProfile/:id", editProfile);
router.post(
  "/updateProfile/:id",
  uploadImageDynamic("profileImage").single("image"), 
  updateProfile
);

router.get("/job-applications", jobApplication);
router.get("/all-users", allUsers);
router.get("/user-status-update/:id", updateUserStatus);


router.get("/categories", allCategories);
router.get("/category-status-update/:id", updateCategoryStatus);


router.get("/subcategories", subcategoriesPage);     
router.get("/subcategories-list", subcategoriesListAjax); 
router.get("/subcategory-status-update/:id", subcategoryStatusUpdate);

router.post(
  "/category-add",
  uploadImageDynamic("categories").single("image"),
  addCategory
);

router.post(
  "/subcategory-add",
  uploadImageDynamic("subcategories").single("image"), 
  addSubcategory
);


router.get("/bank-details/:type", getBankDetails);
router.get("/bank-update-request/:type", getBankUpdateRequests);
router.get(
  "/request-status-update/:id",
  updateRequestStatus
);


router.get("/services/:id", allServisesa);


router.get("/ajax/subcategories/:category_id", getSubcategoriesByCategory);
router.post(
  "/ajax/add-service",
  uploadImageDynamic("serviceImage").single("image"),
  storeService
);


router.get(
  "/service-status-update/:id",
  updateServiceStatus
);

router.get(
  "/service-delete/:id",
  deleteService
);


router.get("/all-drivers", driver_controller);
router.get("/driver-view/:id", driverView);
router.get("/driver-status-update/:id", updateDriverStatus);
router.post("/driver-approve-all", approveAllDocuments);
router.get("/driver-login-status-update/:id", driverLoginStatus);


router.get("/vehicle-list", vehicleList);
router.get("/vehicle-status-update/:id",updateVehicleStatus);
router.post("/vehicle-add",uploadImageDynamic("cabbooking/vehicle_image").single("image"),addVehicle);
router.post("/vehicle-update",uploadImageDynamic("cabbooking/vehicle_image").single("image"),updateVehicle);


router.get("/brand-list", brandList);
router.get("/brand-status-update/:id", updateBrandStatus);
router.post("/brand-add", addBrand);
router.post("/brand-update", updateBrand);



router.get("/model-list", modelList);
router.get("/ajax/brands-by-vehicle/:vehicle_id", getBrandsByVehicle);
router.get("/ajax/models-filter", getModelsByFilter);
router.post("/model-add", addModel);
router.post("/model-update", updateModel);
router.get("/model-status-update/:id",updateModelStatus);


router.get("/vehicle-amount-list", vehicleAmountList);
router.post("/vehicle-amount-add", vehicleAmountAdd);
router.post("/vehicle-amount-update", vehicleAmountUpdate);
router.get("/vehicle-amount-delete/:id", vehicleAmountDelete);


router.get("/serviceman", allServiceman);
router.get("/serviceman-status-update/:id", updateServicemanStatus);

router.get("/settings", allSettings);
router.post("/settings/update", updateSetting);


router.get("/driver-withdraw-request", DriverWithdrawRequest);      
router.get("/driver-withdraw-request/:status", DriverWithdrawRequest);
router.get("/update-withdraw-request/:id", updateWithdrawRequest);


// LIST

router.get("/serviceman-withdraw-request", ServicemanWithdrawRequest);
router.get("/serviceman-withdraw-request/:status", ServicemanWithdrawRequest);
router.get("/update-serviceman-withdraw-request/:id", updateServicemanWithdrawRequest);



export default router;
