import moment from "moment-timezone";

export function parseIST(dateStr) {
  return moment.tz(dateStr, "Asia/Kolkata");
}

export function nowIST() {
  return moment().tz("Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss");
}
