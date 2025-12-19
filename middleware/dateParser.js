import moment from "moment-timezone";

// Convert MySQL datetime → IST
export function parseIST(dateStr) {
  return moment.tz(dateStr, "Asia/Kolkata");
}

// Return current IST in MySQL format
export function nowIST() {
  return moment().tz("Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss");
}
