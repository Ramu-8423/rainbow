import express from "express";
import { uploadImageDynamic } from "../middleware/upload.js";

/* =======================
   USER PUBLIC CONTROLLERS
======================= */
import {
generateRideInvoice
} from "../controllers/api/InvoiceController.js"



import {
  loginPolicy,
  loginAdds,
  userLogin,
  userRegister,
  userProfile,
  profileEdit,
  City,
  getNotificationByType,
  userBanner,
  topServices,
  JobRequest,
  categories,
  subcategories,
  getServices,
  getCoupons,
  applyCoupon,
  saveAddress,
  getSavedAddress,
  deleteSavedAddressByType
} from "../controllers/api/userPublicController.js";

/* =======================
   SERVICEMAN CONTROLLERS
======================= */
import {
  servicemanRegister,
  servicemanLogin,
  servicemanProfile,
  servicemanOnlineStatus,
  zoneCities
} from "../controllers/api/serviceManController.js";

/* =======================
   SERVICE ORDER CONTROLLERS
======================= */
import {
  serviceOrder,
  acceptOrder,
  changeOrderStatus,
  myActiveOrders,
  changePaymentMode,
  addServicemanRating,
  getServicemanRatings
} from "../controllers/api/serviceOrderController.js";

/* =======================
   PAYMENT / WALLET CONTROLLERS
======================= */
import {
  payment,
  bankDetails,
  getBankDetails,
  bankDetailsUpdateRequest,
  getBankUpdateRequest,
  callbackService,
  serviceman_transaction,
  user_transaction,
  servicemanEarnings,
  servicemanServiceInfo
} from "../controllers/api/payinController.js";


import {
  servicemanwithdrawServiceRequest,
  servicemanWithdrawHistory,
  driverWithdrawServiceRequest,
  driverWithdrawHistory
} from "../controllers/api/withdrawController.js";

import {
vehicles,
getCabCancelReasons,
cabHistory,
cabEarning,
submitDriverRating
} from "../controllers/api/cabBookingController.js";


import {
driver_transactions
} from "../controllers/api/driverTransaction.js";



import {
driverOnlineStatus,
getVehicleAmountList,
getDriverCanDiscount,
cabOrder,
getDriverProfilePhotos,
addOrUpdateDriverOffer,
acceptCabRide,
deleteExpiredCabOrders,
changeCabOrderStatus,
activeRide,
cabchangePaymentMode,
letterOrderNotification,
laterAssignOrder,
acceptLaterRide,
driverIgnoreCabOrder,
updateEstimatedAmount
} from "../controllers/api/CaborderController.js";


import {
driverRegister,
getDriverProfile,
getBrandByVehicle,
getModelByBrand,
getColors
} from "../controllers/api/driverController.js";




const router = express.Router();



import { sendOtp, verifyOtp} from "../controllers/api/otpVerifyController.js";

router.get("/send_otp", sendOtp);
router.get("/verifyotp", verifyOtp);

/* =======================
   USER AUTH & PROFILE
======================= */
router.get("/loginPolicy/:id", loginPolicy);
router.get("/loginAdds", loginAdds);
router.post("/user_login", userLogin);
router.post("/user_register", userRegister);
router.get("/profile/:id", userProfile);

router.patch(
  "/profile_edit",
  uploadImageDynamic("UserprofileImage").single("image"),
  profileEdit
);

/* =======================
   USER GENERAL DATA
======================= */
router.get("/cities", City);

router.get("/user_notification/:type", getNotificationByType);




router.get("/User_banner", userBanner);
router.get("/top_services", topServices);

router.post("/save-address", saveAddress);
router.post("/get-saved-address", getSavedAddress);
router.delete("/delete", deleteSavedAddressByType);
/* =======================
   JOB REQUEST
======================= */
router.post(
  "/job_request",
  uploadImageDynamic("JobFiles").fields([
    { name: "profile_photo", maxCount: 1 },
    { name: "police_verification_certificate", maxCount: 1 },
    { name: "designation_file", maxCount: 10 }
  ]),
  JobRequest
);

/* =======================
   CATEGORY / SERVICE / COUPON
======================= */
router.get("/categories", categories);
router.get("/subcategories/:category_id", subcategories);
router.post("/services", getServices);
router.get("/coupons/:id", getCoupons);
router.post("/apply_coupon", applyCoupon);

/* =======================
   SERVICEMAN AUTH & PROFILE
======================= */
router.post(
  "/serviceman_register",
  uploadImageDynamic("ServicemanFiles").fields([
    { name: "profile_photo", maxCount: 1 },
    { name: "aadhaar_front", maxCount: 1 },
    { name: "aadhaar_back", maxCount: 1 },
    { name: "experience_certificate", maxCount: 1 }
  ]),
  servicemanRegister
);


router.post("/serviceman_login", servicemanLogin);
router.post("/serviceman_profile", servicemanProfile);
router.post("/online_status", servicemanOnlineStatus);

/* =======================
   BANK / PAYMENT
======================= */
router.post("/payment", payment);
router.post("/callback_service", callbackService);
router.post("/add_bank_details", bankDetails);
router.post("/get_bank_details", getBankDetails);
router.post("/bank_update_request", bankDetailsUpdateRequest);
router.post("/get_bank_update_request", getBankUpdateRequest);
router.post("/serviceman-service-info", servicemanServiceInfo);

/* =======================
   SERVICE ORDERS
======================= */
router.post("/service_order", serviceOrder);
router.post("/serviceman/accept-order", acceptOrder);
router.post("/change_order_status", changeOrderStatus);
router.post("/my-orders", myActiveOrders);
router.post("/change_payment_mode", changePaymentMode);

/* =======================
   TRANSACTIONS / WALLET
======================= */
router.post("/serviceman_transaction", serviceman_transaction);
router.post("/user-transaction", user_transaction);

router.post("/serviceman-withdraw-request", servicemanwithdrawServiceRequest);
router.post("/serviceman-withdraw-history", servicemanWithdrawHistory);

router.post("/serviceman-earnings", servicemanEarnings);

/* =======================
   RATINGS
======================= */
router.post("/serviceman-rating", addServicemanRating);
router.post("/serviceman-ratings", getServicemanRatings);
router.post("/serviceman-ratings", getServicemanRatings);

/* =======================
   Vehicle 
======================= */
router.get("/vehicles", vehicles);
router.get("/cab-cancel-reasons", getCabCancelReasons);
router.post("/cab-history", cabHistory);
router.post("/cab-earning", cabEarning);


router.post(
  "/driver_register",
  uploadImageDynamic("DriverDocuments").fields([
    { name: "profile_photo", maxCount: 1 },

    { name: "driver_licence_front", maxCount: 1 },
    { name: "driver_licence_back", maxCount: 1 },

    { name: "aadhaar_front", maxCount: 1 },
    { name: "aadhaar_back", maxCount: 1 },
    { name: "pan_card_front", maxCount: 1 },
    { name: "pan_card_back", maxCount: 1 },

    { name: "fitness_certificate", maxCount: 1 },
    { name: "pollution_certificate", maxCount: 1 },
    { name: "insurance_certificate", maxCount: 1 },
    { name: "police_certificate", maxCount: 1 },

    { name: "vehicle_photo", maxCount: 1 },
    { name: "vehicle_permit_part_a", maxCount: 1 },
    { name: "vehicle_permit_part_b", maxCount: 1 },
    { name: "vehicle_registration_front", maxCount: 1 },
    { name: "vehicle_registration_back", maxCount: 1 }
  ]),
  driverRegister
);


router.post("/driver_profile", getDriverProfile);
router.post("/get-brand", getBrandByVehicle);
router.post("/get-model", getModelByBrand);
router.get("/colors", getColors);
router.post("/driver-online-status", driverOnlineStatus);
router.post("/vehicle-amount-list", getVehicleAmountList);
router.post("/driver-can-discount", getDriverCanDiscount);
router.post("/cab_order", cabOrder);
router.post("/driver-profile-photos", getDriverProfilePhotos);
router.post("/driver-offer", addOrUpdateDriverOffer);


router.post("/accept-cab-ride", acceptCabRide);
router.get("/delete-expired-orders", deleteExpiredCabOrders);


router.post("/change-cab-order-status", changeCabOrderStatus);


router.post("/active-ride", activeRide);
router.post("/driver_transactions", driver_transactions);

router.post("/cab-change-payment-mode", cabchangePaymentMode);


router.get("/letterOrderNotification", letterOrderNotification);
router.get("/laterAssignOrder", laterAssignOrder);
router.post("/submit-driver-rating", submitDriverRating);

router.post("/accept-later-ride", acceptLaterRide);



router.post("/driver-withdraw-request", driverWithdrawServiceRequest);
router.post("/driver-withdraw-history", driverWithdrawHistory);
// routes/cab.js
router.post("/driver-ignore-ride-order", driverIgnoreCabOrder);


router.post(
  "/update-estimated-amount",
  updateEstimatedAmount
);



router.get("/zone_cities", zoneCities);


router.get("/ride-invoice/:ride_id", generateRideInvoice);



export default router;
