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
    addSubcategory
} from "../controllers/PublicController.js";


import { 
getBankDetails,
getBankUpdateRequests,
updateRequestStatus
} from "../controllers/BankController.js";


import { 
allServisesa
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


router.get("/servises/:id", allServisesa);

export default router;
